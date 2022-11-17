module Zorro
  # Connect to MongoDB if configured
  if ENV['AOZORA_MONGO_URL'].present?
    CLIENT = Mongo::Client.new(
      ENV['AOZORA_MONGO_URL'],
      max_pool_size: 24,
      logger: Rails.logger
    )
  end

  CACHE = LookupCache.new

  module Database
    # Create shortcuts to various useful collections if we're connected
    if ENV['AOZORA_MONGO_URL'].present?
      # Profiles
      User = CLIENT['_User'] # Parse prefixes the User collection with an underscore
      UserDetails = CLIENT['UserDetails']

      # Follows (which have a strange collection name in Mongo because of Parse)
      Follow = CLIENT['_Join:following:_User']

      # Media
      Anime = CLIENT['Anime']

      # Community
      Post = CLIENT['POST']
      TimelinePost = CLIENT['TimelinePost']
      Thread = CLIENT['THREAD']
      POST_COLLECTIONS = [TimelinePost, Thread, Post].freeze

      # Library
      AnimeProgress = CLIENT['AnimeProgress']
    end

    # Process a Parse pointer and load the document it refers to.
    #
    # @overload assoc(ref)
    #   @param ref [String, Hash] a reference to a document
    #   @return [Hash] the data in the referenced document
    #   @example With a String-based reference
    #     assoc('User$1d2c3b4a') #=> { "_id": "1d2c3b4a", ... }
    #   @example With a Hash-based reference
    #     assoc(
    #       '__type' => 'Pointer'
    #       'className' => 'User',
    #       'objectId' => '1d2c3b4a'
    #     )
    #     #=> { "_id": "1d2c3b4a", ... }
    # @overload assoc(ref)
    #   @param ref [Array<Hash, String>] a list of references to document
    #   @return [Array<Hash>] the data in the referenced documents
    def self.assoc(ref)
      case ref
      when String
        collection, id = ref.split('$')

        Zorro::CLIENT[collection].find(_id: id).limit(1).first
      when Hash
        collection, id = ref.values_at('className', 'objectId')

        Zorro::CLIENT[collection].find(_id: id).limit(1).first
      when Array
        ref.map { |r| assoc(r) }
      end
    end
  end
end
