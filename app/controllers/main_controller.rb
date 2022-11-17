class MainController < JSONAPI::ResourceController
  include DoorkeeperHelpers
  include MaintainIpAddresses
  include Pundit::ResourceController

  def base_url
    super + '/api/edge'
  end

  # TODO: get rid of this dumb hack for Pundit-resources
  def enforce_policy_use(*); end

  around_action :flush_buffered_feeds
  around_action :store_region_on_thread
  around_action :store_user_on_thread
  before_action :validate_token!

  def flush_buffered_feeds
    yield
  ensure
    Feed.client.try(:flush_async)
  end

  def store_region_on_thread
    Thread.current[:region] = request.headers['CF-IPCountry']

    begin
      yield
    ensure
      Thread.current[:region] = nil
    end
  end

  rescue_from Strait::RateLimitExceeded do
    render status: :too_many_requests, json: {
      errors: [
        {
          status: 429,
          title: 'Rate Limit Exceeded'
        }
      ]
    }
  end

  if Raven.configuration.capture_allowed?
    on_server_error do |error|
      extra = {}

      begin
        if error.is_a?(ActiveRecord::StatementInvalid)
          # Clean the stack trace and use that for the fingerprint
          trace = Rails.backtrace_cleaner.clean(error.backtrace)
          trace = trace.map { |line| line.split(/:\d+:/).first }
          extra[:fingerprint] = [error.original_exception.class.name, *trace]
        end
      ensure
        Raven.capture_exception(error, extra)
      end
    end

    before_action :tag_sentry_context

    def tag_sentry_context
      user = current_user&.resource_owner

      Raven.user_context(id: user.id, name: user.name) if user
      Raven.extra_context(url: request.url)
    end
  end
end
