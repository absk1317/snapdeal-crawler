module Users
  # For Signin with facebook and google
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    before_action :find_or_create_user, only: [:google]

    def google
      GoogleAccount.create_account!(@auth, @user) unless @user.google_account
      sign_in_user('Google')
    end

    private

    def find_or_create_user
      @auth = env['omniauth.auth']
      info = @auth.info
      @user = User.where(email: info.email).first || User.create_user!(info)
    end

    def sign_in_user(login_provider)
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: login_provider)
    end
  end
end
