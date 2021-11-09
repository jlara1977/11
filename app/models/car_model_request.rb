class CarModelRequest < ApplicationRecord
  include PowerTypes::Observable

  enum annual_distance: PriceVersion.annual_distances
  enum contract_time: PriceVersion.contract_times

  validates :email, :brand, :model, :annual_distance, :contract_time, presence: true
end

# == Schema Information
#
# Table name: car_model_requests
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  brand           :string           not null
#  model           :string           not null
#  annual_distance :integer          not null
#  contract_time   :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  first_name      :string
#  last_name       :string
#  comment         :text
#  phone_number    :string
#
