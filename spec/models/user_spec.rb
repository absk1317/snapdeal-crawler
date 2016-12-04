require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'has associations intact' do
    it { is_expected.to have_one(:google_account).dependent(:destroy) }
  end

  describe 'has validations intact' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'methods' do
    it 'checks for the create user method on google account' do
      info = mock_google_auth_hash.info
      expect{ User.create_user!(info) }.to change{ User.count }.by(1)
    end

    it 'checks for create user method when invalid credentials are given' do
      info = mock_google_invalid_hash.info
      expect{ User.create_user!(info) }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe "public instance methods" do
    context "responds to methods defined on it" do
      it { is_expected.to respond_to(:google_account) }
    end
  end
end
