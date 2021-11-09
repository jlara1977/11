class Api::V1::CarModelRequestSerializer < ActiveModel::Serializer
  attributes :id, :email, :brand, :model, :annual_distance, :contract_time
end
