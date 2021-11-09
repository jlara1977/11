FactoryBot.define do
  factory :reservation_request do
    car
    price_version { create(:price_version, car: car) }
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
