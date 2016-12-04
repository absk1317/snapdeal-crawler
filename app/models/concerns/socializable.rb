module Socializable
  extend ActiveSupport::Concern

  included do
    validates :uid, :token, :expires_at, presence: true
    belongs_to :user
  end

  # For common class methods
  module ClassMethods
    def create_account!(auth, user)
      credentials = auth.credentials
      create!(
        uid: auth.uid, token: credentials.token, user: user,
        expires_at: Time.zone.at(credentials.expires_at)
      )
    end
  end
end
