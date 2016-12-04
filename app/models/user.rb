class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google]
  has_many :crawls
  has_one :facebook_account, dependent: :destroy
  has_one :google_account, dependent: :destroy

  def self.create_user!(info)
    create!(
      first_name: info.first_name, last_name: info.last_name,
      email: info.email, password: Devise.friendly_token[0, 20]
    )
  end
end
