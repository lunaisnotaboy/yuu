if ENV['ALGOLIA_APP_ID'] && ENV['ALGOLIA_UPDATE_KEY']
  AlgoliaSearch.configuration = {
    api_key: ENV['ALGOLIA_UPDATE_KEY'],
    application_id: ENV['ALGOLIA_APP_ID']
  }
end
