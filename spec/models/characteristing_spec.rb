require 'rails_helper'

RSpec.describe Characteristing, type: :model do
  let(:model) { create(:model) }

  it "has a valid factory" do
    expect(build(:characteristing, characteristical: model)).to be_valid
  end

  describe "associations" do
    it { is_expected.to belong_to(:characteristical) }
    it { is_expected.to belong_to(:characteristic) }
  end
end
