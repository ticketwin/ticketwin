require 'rails_helper'

RSpec.describe Organization, type: :model do
  subject(:organization) { create :organization }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it { is_expected.to have_many :memberships }
  it { is_expected.to have_many :members }
  it { is_expected.to have_one :ownership }
  it { is_expected.to have_one :owner }
  it { is_expected.to have_and_belong_to_many :venues }
end
