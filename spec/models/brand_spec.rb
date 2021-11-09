require 'rails_helper'

RSpec.describe Brand, type: :model do
  it "has a valid factory" do
    expect(build(:brand)).to be_valid
  end
end
