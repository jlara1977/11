FactoryBot.define do
  factory :price_version do
    car
    monthly_price_cents { 230000 }
    monthly_price_currency { :CLP }
    contract_time { '12' }
    annual_distance { '12.000' }
  end
end
