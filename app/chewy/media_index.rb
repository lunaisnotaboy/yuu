class MediaIndex < Chewy::Index
  class << self
    def sfw
      safe_ratings = AgeRatings::SAFE_AGE_RATINGS.map(&:downcase)
      age_ratings = AgeRatings::AGE_RATINGS.map(&:to_s).map(&:downcase)
      unsafe_ratings = age_ratings - safe_ratings
      filter do
        age_rating(:or) != unsafe_ratings
      end
    end

    # Convert from [[id, name], ...] to id => [names...]
    def groupify(plucks)
      plucks.each.with_object({}) do |(id, name), out|
        (out[id] ||= []).push(name)
      end
    end

    # Get character names for a series
    def get_characters(type, ids)
      groupify Casting.joins(:character).where(media_id: ids, media_type: type)
                      .distinct.pluck(:media_id, 'characters.name')
    end

    # Get person names for a series
    def get_people(type, ids)
      groupify Casting.joins(:person).where(media_id: ids, media_type: type)
                      .distinct.pluck(:media_id, 'people.name')
    end

    # Get Streamers for a series
    def get_streamers(type, ids)
      groupify StreamingLink
        .joins(:streamer)
        .where(media_id: ids, media_type: type).distinct
        .pluck(:media_id, 'streamers.site_name')
    end
  end

  define_type Anime.includes(
    :genres,
    :categories
  ) do
    crutch(:people) { |c| MediaIndex.get_people 'Anime', c.map(&:id) }
    crutch(:characters) { |c| MediaIndex.get_characters 'Anime', c.map(&:id) }
    crutch(:streamers) do |c|
      MediaIndex.get_streamers 'Anime', c.map(&:id)
    end

    root date_detection: false do
      include IndexTranslatable

      field :updated_at
      # Titles and freeform text
      translatable_field :titles
      field :abbreviated_titles, type: 'string'
      translatable_field :description
      # Enumerated values
      field :age_rating, :subtype, type: 'string'
      # Various Data
      field :episode_count, type: 'short' # Max of 32k or so is reasonable
      field :average_rating, type: 'float'
      field :start_date, :end_date, :created_at, type: 'date'
      field :status, type: 'string'
      field :season, type: 'string'
      field :year, type: 'short' # Update this before year 32,000
      field :season_year, type: 'short' # ^
      field :genres, value: ->(a) { a.genres.map(&:name) }
      field :categories, value: ->(a) { a.categories.map(&:title) }
      field :user_count, type: 'integer'
      field :favorites_count, type: 'integer'
      field :popularity_rank, type: 'integer'
      # Castings
      field :people, value: ->(a, crutch) { crutch.people[a.id] }
      field :characters, value: ->(a, crutch) { crutch.characters[a.id] }
      # Where to watch
      field :streamers, value: ->(a, crutch) { crutch.streamers[a.id] }
    end
  end

  define_type Manga.includes(:genres, :categories) do
    crutch(:people) { |coll| get_people 'Anime', coll.map(&:id) }
    crutch(:characters) { |coll| get_characters 'Anime', coll.map(&:id) }

    root date_detection: false do
      include IndexTranslatable

      field :updated_at
      # Titles and freeform text
      translatable_field :titles
      field :abbreviated_titles, type: 'string'
      translatable_field :description
      # Enumerated values
      field :age_rating, :subtype, type: 'string'
      # Various Data
      field :chapter_count, type: 'integer' # Manga run for a really long time
      field :average_rating, type: 'float'
      field :start_date, :end_date, :created_at, type: 'date'
      field :status, type: 'string'
      field :year, type: 'short' # Update this before year 32,000
      field :genres, value: ->(a) { a.genres.map(&:name) }
      field :categories, value: ->(a) { a.categories.map(&:title) }
      field :user_count, type: 'integer'
      # Castings
      field :people, value: ->(a, crutch) { crutch.people[a.id] }
      field :characters, value: ->(a, crutch) { crutch.characters[a.id] }
    end
  end

  define_type Drama.includes(:genres, :categories) do
    crutch(:people) { |coll| MediaIndex.get_people 'Drama', coll.map(&:id) }
    crutch(:characters) do |coll|
      MediaIndex.get_characters 'Drama', coll.map(&:id)
    end
    crutch(:streamers) do |coll|
      MediaIndex.get_streamers 'Drama', coll.map(&:id)
    end

    root date_detection: false do
      include IndexTranslatable

      field :updated_at
      # Titles and freeform text
      translatable_field :titles
      field :abbreviated_titles, type: 'string'
      translatable_field :description
      # Enumerated values
      field :age_rating, :subtype, type: 'string'
      # Various Data
      field :episode_count, type: 'short' # Max of 32k or so is reasonable
      field :average_rating, type: 'float'
      field :start_date, :end_date, :created_at, type: 'date'
      field :status, type: 'string'
      field :year, type: 'short' # Update this before year 32,000
      field :genres, value: ->(a) { a.genres.map(&:name) }
      field :categories, value: ->(a) { a.categories.map(&:title) }
      field :user_count, type: 'integer'
      # Castings
      field :people, value: ->(a, crutch) { crutch.people[a.id] }
      field :characters, value: ->(a, crutch) { crutch.characters[a.id] }
      # Where to watch
      field :streamers, value: ->(a, crutch) { crutch.streamers[a.id] }
    end
  end
end
