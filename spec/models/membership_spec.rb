require 'rails_helper'

RSpec.describe Membership, type: :model do
  subject(:membership) { create :membership }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it { is_expected.to validate_presence_of :organization }
  it { is_expected.to validate_presence_of :user }

  it 'is a non-owning membership' do
    expect(subject).to_not be_ownership
  end

  context 'ownership' do
    subject(:membership) { create :membership, :ownership }

    it 'is a owning membership' do
      expect(subject).to be_ownership
    end
  end
end
