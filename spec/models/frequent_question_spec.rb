require 'rails_helper'

RSpec.describe FrequentQuestion, type: :model do
  it "has a valid factory" do
    expect(build(:frequent_question)).to be_valid
  end
end
