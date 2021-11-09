FactoryBot.define do
  factory :brand do
    name { Faker::Company.name }
    landing_view { true }
  end
end
