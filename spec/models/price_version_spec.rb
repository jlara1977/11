require 'rails_helper'

RSpec.describe PriceVersion, type: :model do
  it "has a valid factory" do
    expect(build(:price_version)).to be_valid
  end

  describe "associations" do
    it { is_expected.to belong_to(:car) }
  end
end
