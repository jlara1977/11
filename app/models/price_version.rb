class PriceVersion < ApplicationRecord
  belongs_to :car

  monetize :monthly_price_cents

  validates :car_id, uniqueness: { scope: [:annual_distance, :contract_time] }

  enum annual_distance: { '12.000': 0, '18.000': 1, '24.000': 2, '30.000': 3, '40.000': 4,
                          '50.000': 5 }
  enum contract_time: { '12': 0, '24': 1, '36': 2, '48': 3 }

  def self.combined_contract_time_with_annual_distances
    response = []
    contract_times.each_key do |contract_time|
      annual_distances.each_key do |annual_distance|
        response.push("#{contract_time}-#{annual_distance}")
      end
    end
    response
  end
end

# == Schema Information
#
# Table name: price_versions
#
#  id                     :bigint(8)        not null, primary key
#  car_id                 :bigint(8)        not null
#  monthly_price_cents    :bigint(8)        default(0), not null
#  monthly_price_currency :string           default("CLP"), not null
#  annual_distance        :integer          not null
#  contract_time          :integer          not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_price_versions_on_car_and_distance_and_time  (car_id,annual_distance,contract_time) UNIQUE
#  index_price_versions_on_car_id                     (car_id)
#
# Foreign Keys
#
#  fk_rails_...  (car_id => cars.id)
#
