require 'rails_helper'

RSpec.describe Car, type: :model do
  it "has a valid factory" do
    expect(build(:car)).to be_valid
  end

  describe "associations" do
    it { is_expected.to belong_to(:model) }
    it { is_expected.to have_many(:price_versions) }
    it { is_expected.to have_many(:characteristings) }
    it { is_expected.to have_many(:characteristics) }
  end
end
