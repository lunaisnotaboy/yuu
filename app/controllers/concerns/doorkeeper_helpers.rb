module DoorkeeperHelpers
  extend ActiveSupport::Concern

  def store_user_on_thread
    Thread.current[:current_user] = doorkeeper_token&.resource_owner

    begin
      yield
    ensure
      Thread.current[:current_user] = nil
    end
  end

  def current_user
    doorkeeper_token
  end

  # Return boolean representing whether there is a user signed in
  def signed_in?
    current_user&.resource_owner.present?
  end

  # Validate token
  def validate_token!
    # If we have a token, but it's not valid, explode
    if doorkeeper_token && !doorkeeper_token.accessible?
      response.headers['WWW-Authenticate'] = 'Bearer'

      render json: {
        errors: [
          { title: 'Invalid token', status: '401' }
        ]
      }, status: :unauthorized
    end
  end

  # Provide context of current user to JR
  def context
    { current_user: current_user }
  end
end
