module OmniauthMacros
    def mock_google_auth_hash
      OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
        'provider' => 'google',
        'uid' => '123545',
        'info' => {
          'first_name' => 'google',
          'last_name' => 'user',
          'email' => 'valid@email.com'
        },
        'credentials' => {
          'token' => "googletoken",
          'secret' => "googlesecret"
        }
      })
    end

    def mock_google_invalid_hash
      OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
        'info' => {
          'email' => 'invalidemail'
        }
      })
    end
end
