FactoryBot.define do
  factory :model do
    brand
    name { Faker::FunnyName.name }
    active { true }
  end
end
