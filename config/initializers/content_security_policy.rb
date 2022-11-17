# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Kitsu::Application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self, :https
    policy.font_src :self, :https, :data
    policy.img_src :self, :https, :data
    policy.media_src :self, :https, :data
    policy.object_src :none
    policy.script_src :self, :https
    policy.script_src(*policy.script_src, :blob) if Rails.env.test?
    # Allow @vite/client to hot reload javascript changes in development
    if Rails.env.development?
      policy.script_src(*policy.script_src, :unsafe_eval,
        "http://#{ViteRuby.config.host_with_port}")
    end
    policy.style_src :self, :unsafe_inline, :https
    policy.connect_src :self, :https
    # Allow @vite/client to hot reload changes in development
    if Rails.env.development?
      policy.connect_src(*policy.connect_src,
        "ws://#{ViteRuby.config.host_with_port}")
    end

    # Specify URI for violation reports
    # policy.report_uri '/csp-violation-report-endpoint'
  end

  # Generate session nonces for permitted importmap and inline scripts
  config.content_security_policy_nonce_generator = ->(_request) { SecureRandom.base64(64) }
  config.content_security_policy_nonce_directives = %w[script-src]

  # Report violations without enforcing the policy.
  # config.content_security_policy_report_only = true
end
