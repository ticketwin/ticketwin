require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create :user }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it { is_expected.to validate_uniqueness_of :api_token }
end
