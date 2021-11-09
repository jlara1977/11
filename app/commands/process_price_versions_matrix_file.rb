require 'roo'

class ProcessPriceVersionsMatrixFile < PowerTypes::Command.new(:file_url)
  def perform
    hash_rows.each do |hash_row|
      car_version = Car.where(id: hash_row['car_id']).first
      if car_version.present?
        PriceVersion.combined_contract_time_with_annual_distances.each do |key|
          new_price_value = hash_row[key]
          if new_price_value.present? && new_price_value.positive?
            create_or_update_price_version(car_version, key, new_price_value)
          end
        end
        if hash_row['valid_date'].present?
          car_version.update!(last_valid_date_prices: hash_row['valid_date'])
        end
      end
    end
  end

  private

  def hash_rows
    prefix = Rails.env.development? ? 'http://localhost:3000' : ''
    spreadsheet = Roo::Spreadsheet.open("#{prefix}#{@file_url}")
    spreadsheet.parse(headers: true).drop(1)
  end

  def create_or_update_price_version(car, distance_and_time_key, new_monthly_price_centts)
    contract_time, annual_distance = distance_and_time_key.split('-')
    price_version = car.price_versions.find_or_initialize_by(
      contract_time: contract_time, annual_distance: annual_distance
    )
    price_version.monthly_price_cents = new_monthly_price_centts
    price_version.save!
  end
end
