class Characteristic < ApplicationRecord
  before_save { name.downcase! }

  enum category: { comfort: 0, multimedia: 1, security: 2 }
end

# == Schema Information
#
# Table name: characteristics
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#
# Indexes
#
#  index_characteristics_on_name_and_category  (name,category) UNIQUE
#
