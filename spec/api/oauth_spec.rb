require 'rails_helper'
require 'oauth2'

RSpec.describe 'OAuth2', type: :request do
  let(:oauth_app) { create(:oauth_application) }
  let(:user) { create(:user) }
  let(:client) do
    OAuth2::Client.new(oauth_app.uid, oauth_app.secret,
      authorize_url: '/api/oauth/authorize',
      token_url: '/api/oauth/token') do |b|
      b.request :url_encoded
      b.adapter :rack, Rails.application
    end
  end

  context 'with Resource Owner Password flow' do
    it 'works if given the email and right password' do
      expect {
        client.password.get_token(user.email, user.password)
      }.not_to raise_error
    end

    it 'does not work if given the wrong password' do
      expect {
        client.password.get_token(user.email, '123')
      }.to raise_error(OAuth2::Error)
    end
  end
end
