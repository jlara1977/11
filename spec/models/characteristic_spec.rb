require 'rails_helper'

RSpec.describe Characteristic, type: :model do
  it "has a valid factory" do
    expect(build(:characteristic)).to be_valid
  end
end
