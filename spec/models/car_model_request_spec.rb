require 'rails_helper'

RSpec.describe CarModelRequest, type: :model do
  it "has a valid factory" do
    expect(build(:car_model_request)).to be_valid
  end
end
