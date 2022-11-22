namespace :graphql do
  task dump_schema: :environment do
    require 'graphql/rake_task'

    GraphQL::RakeTask.new(
      directory: './', # Creates `./schema.graphql`
      load_schema: ->(_task) {
        require File.expand_path('../../app/graphql/kitsu_schema', __dir__)

        KitsuSchema
      }
    )

    Rake::Task['graphql:schema:idl'].invoke
  end
end
