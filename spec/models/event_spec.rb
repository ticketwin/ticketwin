require 'rails_helper'

RSpec.describe Event, type: :model do
  subject(:event) { create :event }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it { is_expected.to belong_to :organization }
  it { is_expected.to have_many :transitions }
  it { is_expected.to have_one :event_sale }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :organization }
  it { is_expected.to validate_presence_of :state }
  it { is_expected.to validate_presence_of :start_time }
  it { is_expected.to validate_presence_of :end_time }
end
