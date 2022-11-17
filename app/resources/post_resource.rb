class PostResource < BaseResource
  caching
  IMMUTABLE_ATTRIBUTES = %i[locked_at locked_reason].freeze
  IMMUTABLE_FIELDS = (IMMUTABLE_ATTRIBUTES + %i[locked_by]).freeze

  attributes :content, :content_formatted, :comments_count, :post_likes_count,
    :spoiler, :nsfw, :blocked, :deleted_at, :top_level_comments_count,
    :edited_at, :target_interest, :embed, :embed_url

  attributes(*IMMUTABLE_ATTRIBUTES)

  has_one :user
  has_one :target_user
  has_one :target_group
  has_one :media, polymorphic: true
  has_one :spoiled_unit, polymorphic: true
  has_one :ama, foreign_key: 'original_post_id', foreign_key_on: :related
  has_one :locked_by, class_name: 'User'
  has_many :post_likes
  has_many :comments
  has_many :uploads

  def self.creatable_fields(context)
    super - IMMUTABLE_FIELDS
  end

  def self.updatable_fields(context)
    super - IMMUTABLE_FIELDS
  end

  def target_interest=(val)
    _model.target_interest = val.underscore.classify
  end

  def target_interest
    _model&.target_interest&.underscore&.dasherize
  end
end
