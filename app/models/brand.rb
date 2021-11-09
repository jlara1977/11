class Brand < ApplicationRecord
  has_many :models, dependent: :destroy
  has_one :image, dependent: :destroy, as: :imagable, inverse_of: :imagable

  validates :name, uniqueness: { case_sensitive: false }

  scope :for_landing, -> { where(landing_view: true) }
  scope :active, -> { joins(:models).where(models: { active: true }).distinct }
end

# == Schema Information
#
# Table name: brands
#
#  id           :bigint(8)        not null, primary key
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  landing_view :boolean          default(FALSE)
#
# Indexes
#
#  index_brands_on_name  (name) UNIQUE
#
