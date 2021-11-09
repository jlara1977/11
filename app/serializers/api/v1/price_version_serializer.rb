class Api::V1::PriceVersionSerializer < ActiveModel::Serializer
  attributes :id, :monthly_price, :annual_distance, :contract_time, :car_id,
             :formatted_monthly_price

  def formatted_monthly_price
    object.monthly_price.format(symbol: true, with_currency: false, format: "%u%n")
  end
end
