class Image < ApplicationRecord
  include PowerTypes::Observable
  include ImageUploader::Attachment(:image)

  belongs_to :imagable, polymorphic: true

  validate :only_one_main_image_by_model

  def only_one_main_image_by_model
    if imagable_type == 'Model' && changes['main_model_image'].present? &&
        changes['main_model_image'].last == true &&
        imagable.images.find_by(main_model_image: true).present?
      errors.add(:main_model_image,
                 "There can not be two images with main model image attribute true. Image with\
                 main_model_image has id #{imagable.images.find_by(main_model_image: true).id}")
    end
  end
end

# == Schema Information
#
# Table name: images
#
#  id               :bigint(8)        not null, primary key
#  imagable_type    :string           not null
#  imagable_id      :bigint(8)        not null
#  image_data       :jsonb
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  main_model_image :boolean          default(FALSE)
#
# Indexes
#
#  index_images_on_imagable_type_and_imagable_id  (imagable_type,imagable_id)
#
