require 'rails_helper'

RSpec.describe EventSale, type: :model do
  subject(:event_sale) { create :event_sale }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it { is_expected.to belong_to :event }
end
