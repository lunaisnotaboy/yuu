require 'authorization/assertion/facebook'
require 'authorization/password'

Doorkeeper.configure do
  orm :active_record

  # HACK: this idiocy is O(n) so try to avoid choking the database
  token_lookup_batch_size 500

  # => Authentication
  # Check whether the resource owner is authenticated or not.
  resource_owner_authenticator do
    # TODO: write error! method
    User.find(doorkeeper_token[:resource_owner_id]) || error!
  end

  # Authenticate in Resource Owner Password flow
  resource_owner_from_credentials do
    Authorization::Password.new(params[:username], params[:password]).user!
  end

  resource_owner_from_assertion do
    case params[:provider]
    when 'facebook'
      Authorization::Assertion::Facebook.new(params[:assertion]).user!
    end
  end

  # Restrict access to the web interface for adding OAuth applications
  admin_authenticator do
    # TODO: write error! method and use Pundit
    User.find(doorkeeper_token[:resource_owner_id])
  end
end
