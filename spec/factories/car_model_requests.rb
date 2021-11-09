FactoryBot.define do
  factory :car_model_request do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    brand { Faker::Vehicle.make }
    model { Faker::Vehicle.model(make_of_model: brand) }
    annual_distance { CarModelRequest.annual_distances.keys.first }
    contract_time { CarModelRequest.contract_times.keys.first }
    comment { 'Un comentario!' }
  end
end
