# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Yuu
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = 'Central Time (US & Canada)'
    # config.eager_load_paths << Rails.root.join('extras')

    # Use Sidekiq as the queue adapter for Active Job.
    config.active_job.queue_adapter = :sidekiq

    # Use `structure.sql` instead of `schema.rb`.
    config.active_record.schema_format = :sql

    # Use memcached to cache data.
    config.cache_store = :mem_cache_store

    # Use the lowest log level
    config.log_level = ENV.fetch('RAILS_LOG_LEVEL', 'debug').to_sym
  end
end
