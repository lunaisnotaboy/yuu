class MediaActivityService
  attr_reader :library_entry
  delegate :media, to: :library_entry
  delegate :user, to: :library_entry

  def initialize(library_entry)
    @library_entry = library_entry
  end

  def status(status)
    fill_defaults user.profile_feed.activities.new(
      foreign_id: "LibraryEntry:#{library_entry.id}:updated-#{status}",
      verb: 'updated',
      status: status
    )
  end

  def rating(rating)
    fill_defaults user.profile_feed.activities.new(
      foreign_id: "LibraryEntry:#{library_entry.id}:rated",
      verb: 'rated',
      rating: rating,
      nineteen_scale: true,
      time: Date.today.to_time
    )
  end

  def reviewed(review)
    fill_defaults user.profile_feed.activities.new(
      foreign_id: review,
      verb: 'reviewed',
      review: review,
      to: [media&.feed&.no_fanout]
    )
  end

  def fill_defaults(activity)
    activity.tap do |act|
      act.actor ||= user
      act.object ||= library_entry
      act.to ||= []
      act.media ||= media
      act.nsfw ||= media.try(:nsfw?)
      act.foreign_id ||= library_entry
      act.time ||= Time.now
    end
  end
end
