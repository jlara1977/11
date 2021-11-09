class Api::V1::BrandSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url

  def image_url
    object.image&.image_url
  end
end
