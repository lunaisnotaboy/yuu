require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kitsu
  # noinspection ALL
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # CSRF protection breaks some of our routes, so make it opt-in.
    # noinspection RubyResolve
    config.action_controller.default_protect_from_forgery = false

    # Use `structure.sql` instead of `schema.rb`.
    config.active_record.schema_format = :sql

    # Use UTC for the time zone.
    config.time_zone = 'UTC'

    # Clients are in charge of localization, so we get out of the way and do our best to help them
    config.i18n.enforce_available_locales = false
    config.i18n.default_locale = :en
    config.i18n.fallbacks = true

    # Include all concern directories in `app/*/concerns`.
    concern_dirs = Dir['app/*/concerns'].map { |d| File.expand_path(d) }
    config.eager_load_paths += concern_dirs

    # Rip out any non-unique entries.
    config.eager_load_paths.uniq!

    # Allow the auto loading of any files under `lib`.
    config.autoload_paths << Rails.root.join('lib')

    # Set log level to `LOG_LEVEL` environment variable.
    config.log_level = ENV.fetch('LOG_LEVEL', 'info').to_sym

    config.ssl_options = {
      redirect: {
        exclude: ->(request) { request.path.start_with?('/api/_health') }
      }
    }

    # Set up Flipper's Memoizer middleware.
    config.middleware.insert_before 0, Flipper::Middleware::Memoizer

    # Enable CORS.
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any,
          methods: :any,
          credentials: false,
          max_age: 1.hour
      end
    end

    # Configure Action Mailer.
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.deliver_later_queue_name = 'soon'

    if ENV['POSTMARK_API_TOKEN']
      config.action_mailer.delivery_method = :postmark
      config.action_mailer.postmark_settings = {
        api_token: ENV['POSTMARK_API_TOKEN']
      }
    else
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.smtp_settings = {
        address: ENV.fetch('SMTP_ADDRESS', nil),
        port: ENV['SMTP_PORT']&.to_i,
        user_name: ENV.fetch('SMTP_USERNAME', nil),
        password: ENV.fetch('SMTP_PASSWORD', nil),
        authentication: ENV['SMTP_AUTHENTICATION']&.to_sym
      }.compact
    end

    # Configure Redis cache.
    config.cache_store = :redis_cache_store, {
      driver: :hiredis,
      url: ENV.fetch('REDIS_URL', nil),
      expires_in: 1.day
    }

    # Make Sidekiq the default Active Job adapter.
    config.active_job.queue_adapter = :sidekiq
    config.active_job.default_queue_name = :later

    # Configure scaffold generators.
    config.generators do |g|
      g.authorization :policy
      g.serialization :jsonapi_resource
      g.resource_controller :resource_controller
    end
  end
end
