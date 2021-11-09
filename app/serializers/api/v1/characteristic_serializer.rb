class Api::V1::CharacteristicSerializer < ActiveModel::Serializer
  attributes :id, :name, :category
end
