require 'rails_helper'

RSpec.describe ReservationRequest, type: :model do
  it "has a valid factory" do
    expect(build(:reservation_request)).to be_valid
  end

  describe "associations" do
    it { is_expected.to belong_to(:car) }
    it { is_expected.to belong_to(:price_version) }
  end
end
