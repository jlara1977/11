class Car < ApplicationRecord
  include HasCharacteristics

  belongs_to :model
  delegate :brand, to: :model

  has_many :price_versions,
           -> { order('annual_distance ASC, monthly_price_cents ASC') },
           dependent: :destroy,
           inverse_of: :car

  enum shift: { manual: 0, automatic: 1 }
  enum fuel: { diesel: 0, benzine: 1 }
  enum traction: { front_wheel_drive: 0, all_wheel_drive: 1 }

  scope :active, -> { joins(:model).where(models: { active: true }) }

  def name
    version_name || "#{model.name} - #{shift} - #{fuel}"
  end
end

# == Schema Information
#
# Table name: cars
#
#  id                     :bigint(8)        not null, primary key
#  model_id               :bigint(8)        not null
#  shift                  :integer
#  fuel                   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  traction               :integer          default("front_wheel_drive")
#  version_name           :string
#  row_seats              :integer          default(2)
#  airbags                :integer
#  last_valid_date_prices :date
#
# Indexes
#
#  index_cars_on_model_id  (model_id)
#
# Foreign Keys
#
#  fk_rails_...  (model_id => models.id)
#
