class ReservationRequest < ApplicationRecord
  include PowerTypes::Observable
  belongs_to :car
  belongs_to :price_version

  validates :email, :first_name, :last_name, presence: true

  delegate :model, to: :car

  enum kind: { 'company': 0, 'person': 1 }
end

# == Schema Information
#
# Table name: reservation_requests
#
#  id               :bigint(8)        not null, primary key
#  car_id           :bigint(8)        not null
#  email            :string           not null
#  first_name       :string           not null
#  last_name        :string           not null
#  contact_number   :string
#  kind             :integer
#  comment          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  price_version_id :bigint(8)
#
# Indexes
#
#  index_reservation_requests_on_car_id            (car_id)
#  index_reservation_requests_on_price_version_id  (price_version_id)
#
# Foreign Keys
#
#  fk_rails_...  (car_id => cars.id)
#  fk_rails_...  (price_version_id => price_versions.id)
#
