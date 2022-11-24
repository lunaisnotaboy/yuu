# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Yuu::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  config.action_controller.perform_caching = true
  config.action_controller.enable_fragment_cache_logging = true

  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{2.days.to_i}"
  }

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Set the default Action Mailer URL.
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Use the cache store for user sessions.
  config.session_store :cache_store

  # Use Letter Opener Web for emails.
  config.action_mailer.delivery_method = :letter_opener_web
  config.action_mailer.perform_deliveries = true
end
