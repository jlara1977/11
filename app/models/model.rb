class Model < ApplicationRecord
  include HasCharacteristics

  belongs_to :brand
  has_many :cars, dependent: :destroy
  has_many :price_versions, through: :cars
  has_many :images, dependent: :destroy, as: :imagable, inverse_of: :imagable
  has_one :technical_file,
          as: :documentable, class_name: 'Document', inverse_of: :documentable, dependent: :destroy

  enum car_type: { pickup_truck: 0, SUV: 1, hatchback: 2, sedan: 3, citycar: 4, comercial: 5 }

  scope :active, -> { where(active: true) }
  scope :active_and_sorted_by_minimum_price, -> do
    active.joins(:price_versions).group(:id).order('MIN(monthly_price_cents)')
  end
  scope :prioritized_display, -> { where(prioritized_display: true) }

  validate :max_prioritized_display
  validates :name, uniqueness: { case_sensitive: false }

  def main_image
    images.find_by(main_model_image: true)
  end

  def cars_sorted_by_minimum_price_cents
    cars.joins(:price_versions).group(:id).order('MIN(monthly_price_cents)')
  end

  def max_prioritized_display
    if Model.prioritized_display.size >= ENV['MAX_PRIORITIZED_MODELS'].to_i &&
        changes['prioritized_display'].present? && changes['prioritized_display'].first == false &&
        changes['prioritized_display'].last == true
      errors.add(:max_prioritized_display, 'Se excedio el nro de modelos priorizables')
    end
  end
end

# == Schema Information
#
# Table name: models
#
#  id                  :bigint(8)        not null, primary key
#  name                :string           not null
#  brand_id            :bigint(8)        not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  car_type            :integer
#  active              :boolean          default(TRUE)
#  prioritized_display :boolean          default(FALSE)
#
# Indexes
#
#  index_models_on_brand_id  (brand_id)
#  index_models_on_name      (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#
