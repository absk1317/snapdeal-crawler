require 'rails_helper'

RSpec.describe GoogleAccount, type: :model do

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:uid) }
    it { is_expected.to validate_presence_of(:token) }
  end
end
