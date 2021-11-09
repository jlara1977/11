class Api::V1::ImageSerializer < ActiveModel::Serializer
  attributes :id, :imagable, :image_url, :main_model_image
end
