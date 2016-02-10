require 'rails_helper'

RSpec.describe BoxOffice, type: :model do
  subject(:box_office) { create :box_office }

  it 'is valid' do
    expect(subject).to be_valid
  end

  it { is_expected.to belong_to :event }
end
