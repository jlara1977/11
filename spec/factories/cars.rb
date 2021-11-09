FactoryBot.define do
  factory :car do
    model
    shift { 'automatic' }
    fuel { 'benzine' }
  end
end
