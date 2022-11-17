class MediaImporter
  class ImportFile
    attr_reader :data

    def initialize(base_media_url, anime_assoc_file, genre_map_file)
      # Loading the JSON
      utc = Time.now.to_i.to_s
      anime_json_file = open(
        base_media_url +
          anime_assoc_file +
          '?' +
          utc
      ).read

      @data = JSON.parse(anime_json_file)

      genre_category_map = open(
        base_media_url +
          genre_map_file +
          '?' +
          utc
      ).read

      @gc_data = JSON.parse(genre_category_map)
      @gc_data.update(@gc_data) { |_, v| Category.where(title: v)[0] if v }
    end

    def associate_media_categories(media)
      genres = media.genres
      categories = []

      genres.each do |g|
        categories << @gc_data[g[:name]]
      end

      categories = categories.compact
      media.categories = categories if categories.any?
    end

    def associate_manga!
      puts 'Associating Manga Categories From Kitsu Genre Map'

      manga = Manga.includes(:genres).all

      manga.each do |m|
        associate_media_categories(m)
      end
    end
  end
end
