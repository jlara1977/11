class FrequentQuestion < ApplicationRecord
  enum category: {
    contract_process: 0,
    services: 1,
    not_included_values: 2,
    end_of_contract: 3,
    services_zones: 4
  }
end

# == Schema Information
#
# Table name: frequent_questions
#
#  id         :bigint(8)        not null, primary key
#  question   :text             not null
#  answer     :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#
