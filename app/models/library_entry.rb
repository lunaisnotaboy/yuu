class LibraryEntry < ApplicationRecord
  VALID_RATINGS = (2..20).to_a.freeze
  MEDIA_ASSOCIATIONS = %i[anime manga drama].freeze

  belongs_to :user
  belongs_to :media, polymorphic: true
  belongs_to :anime, optional: true
  belongs_to :manga, optional: true
  belongs_to :drama, optional: true
  has_one :review, dependent: :destroy
  has_one :media_reaction, dependent: :destroy
  has_many :library_events, dependent: :destroy

  scope :sfw, -> { where(nsfw: false) }
  scope :by_kind, ->(*kinds) do
    t = arel_table
    columns = kinds.map { |k| t[:"#{k}_id"] }
    scope = columns.shift.not_eq(nil)
    columns.each do |col|
      scope = scope.or(col.not_eq(nil))
    end
    where(scope)
  end
  scope :privacy, ->(privacy) { where(private: !(privacy == :public)) }
  scope :visible_for, ->(user) {
    scope = user && !user.sfw_filter? ? all : sfw

    return scope.privacy(:public) unless user
    return scope if user.permissions.admin?

    scope.privacy(:public).or(
      where(user_id: user).privacy(:private)
    )
  }

  enum status: {
    current: 1,
    planned: 2,
    completed: 3,
    on_hold: 4,
    dropped: 5
  }
  enum reaction_skipped: {
    unskipped: 0,
    skipped: 1,
    ignored: 2
  }
  attr_accessor :imported

  validates :user, :status, :progress, :reconsume_count, presence: true
  validates :media, polymorphism: { type: Media }, presence: true
  validates :anime_id, uniqueness: { scope: :user_id }, allow_nil: true
  validates :manga_id, uniqueness: { scope: :user_id }, allow_nil: true
  validates :drama_id, uniqueness: { scope: :user_id }, allow_nil: true
  validates :progress, numericality: { greater_than_or_equal_to: 0 }
  validates :reconsume_count, numericality: { greater_than_or_equal_to: 0 }
  validates :rating, numericality: {
    greater_than_or_equal_to: 2,
    less_than_or_equal_to: 20
  }, allow_blank: true
  validates :reconsume_count, numericality: {
    less_than_or_equal_to: 50,
    message: 'just... go outside'
  }
  validate :progress_limit
  validate :one_media_present

  counter_culture :user, column_name: ->(le) { 'ratings_count' if le.rating },
    execute_after_commit: true
  scope :rated, -> { where.not(rating: nil) }
  scope :following, ->(user) do
    user_id = user.respond_to?(:id) ? user.id : user
    user_id = sanitize(user_id.to_i) # Juuuuuust to be safe
    follows = Follow.arel_table
    sql = follows.where(follows[:follower_id].eq(user_id)).project(:followed_id)
    where("user_id IN (#{sql.to_sql})")
  end
  scope :completed_at_least_once, -> { completed.or(where('reconsume_count > ?', 0)) }

  def completed_at_least_once?
    completed? || reconsume_count&.positive?
  end

  def progress_limit
    return unless progress
    progress_cap = media&.progress_limit
    default_cap = [media&.default_progress_limit, 50].compact.max

    if progress_cap&.nonzero?
      errors.add(:progress, 'cannot exceed length of media') if progress > progress_cap
    elsif default_cap && progress > default_cap
      errors.add(:progress, 'is rather unreasonably high')
    end
  end

  def one_media_present
    media_present = MEDIA_ASSOCIATIONS.select { |col| send(col).present? }
    return if media_present.count == 1
    media_present.each do |col|
      errors.add(col, 'must have exactly one media present')
    end
  end

  def unit
    media.unit(progress)
  end

  def next_unit
    media.unit(progress + 1)
  end

  def kind
    if anime.present? then :anime
    elsif manga.present? then :manga
    elsif drama.present? then :drama
    end
  end

  def recalculate_time_spent!
    new_time_spent = 0
    new_time_spent += media.episodes.for_progress(progress).sum(:length)
    new_time_spent += media.total_length * reconsume_count if media.total_length
    update(time_spent: new_time_spent)
  end

  before_validation do
    # TEMPORARY: If media is set, copy it to kind_id, otherwise if kind_id is
    # set, copy it to media!
    if kind && send(kind).present?
      self.media = send(kind)
    else
      kind = media_type&.underscore
      send("#{kind}=", media) if kind
    end

    self.nsfw = media.nsfw? if media_id_changed?
    true
  end

  before_destroy do
    review&.update_attribute(:library_entry_id, nil)
  end

  before_save do
    # When progress equals total episodes
    self.status = :completed if !status_changed? && progress == media&.progress_limit

    if status_changed? && completed? && media&.progress_limit
      # update progress to the cap
      self.progress = media.progress_limit
    end

    unless imported
      self.progressed_at = Time.now if status_changed? || progress_changed?

      if status_changed?
        self.started_at ||= Time.now if current?
        self.started_at ||= Time.now if completed?
        self.finished_at ||= Time.now if completed?
      end

      self.status = :current if progress_changed? && !status_changed?
    end
  end

  after_save do
    # Disable activities and trending vote on import
    unless imported || private?
      media.trending_vote(user, 0.5) if saved_change_to_progress?
      media.trending_vote(user, 1.0) if saved_change_to_status?
    end

    if saved_change_to_rating?
      media.transaction do
        media.decrement_rating_frequency(rating_before_last_save)
        media.increment_rating_frequency(rating)
      end
      user.update_feed_completed!
      user.update_profile_completed!
    end

    if saved_change_to_progress?
      guess = [(progress + 1), media.default_progress_limit].min
      media.update_unit_count_guess(guess)
    end
  end

  LibraryTimeSpentCallbacks.hook(self)
  LibraryStatCallbacks.hook(self)
  LibraryEventCallbacks.hook(self)

  after_commit on: :destroy do
    MediaFollowService.new(user, media).destroy
  end

  after_commit on: :create do
    MediaFollowService.new(user, media).create
  end

  after_commit(on: :create, if: :sync_to_mal?) do
    LibraryEntryLog.create_for(:create, self, myanimelist_linked_account)
    ListSync::UpdateWorker.perform_async(myanimelist_linked_account.id, id)
  end

  after_commit(on: :update, if: :sync_to_mal?) do
    LibraryEntryLog.create_for(:update, self, myanimelist_linked_account)
    ListSync::UpdateWorker.perform_async(myanimelist_linked_account.id, id)
  end

  after_commit(on: :destroy, if: :sync_to_mal?) do
    LibraryEntryLog.create_for(:destroy, self, myanimelist_linked_account)
    ListSync::DestroyWorker.perform_async(myanimelist_linked_account.id,
      media_type, media_id)
  end

  def sync_to_mal?
    return unless media_type.in? %w[Anime Manga]
    return false if imported

    myanimelist_linked_account.present?
  end

  def myanimelist_linked_account
    @mal_linked_account ||= User.find(user_id).linked_accounts.find_by(
      sync_to: true,
      type: 'LinkedAccount::MyAnimeList'
    )
  end
end
