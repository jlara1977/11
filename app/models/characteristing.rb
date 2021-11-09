class Characteristing < ApplicationRecord
  belongs_to :characteristical, polymorphic: true
  belongs_to :characteristic
end

# == Schema Information
#
# Table name: characteristings
#
#  id                    :bigint(8)        not null, primary key
#  characteristical_type :string           not null
#  characteristical_id   :bigint(8)        not null
#  characteristic_id     :bigint(8)        not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_characteristics_on_characteristical    (characteristical_type,characteristical_id)
#  index_characteristings_on_characteristic_id  (characteristic_id)
#
# Foreign Keys
#
#  fk_rails_...  (characteristic_id => characteristics.id)
#
