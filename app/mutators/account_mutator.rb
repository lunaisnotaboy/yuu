class AccountMutator
  # Create an account for a User
  #
  # @param [String] email The email address of the User to register
  # @param [String] password The password to set for the User
  # @param [String] name The name of the User
  # @param [Hash, nil] external_identity An external account to associate
  #   with the User
  # @option external_identity [:facebook] :provider The provider of the
  #   external account
  # @option external_identity [String] :id The ID of the User's account
  #   on the external provider
  # @return [User] The User that was created
  # @raises [ActiveRecord::ActiveRecordError] If the email is already
  #   registered
  # @raises [ArgumentError] If the provider is unknown
  def self.create(email:, password:, name:, external_identity: nil)
    if external_identity && external_identity[:provider] != :facebook
      raise ArgumentError, 'Identity provider is not supported'
    end

    # TODO: send the email in-band and see if it hard-bounces before creation

    User.create!(
      email: email,
      password: password,
      name: name,
      facebook_id: external_identity && external_identity[:id]
    )
  end
end
