class GenerateImageDerivativesJob < ApplicationJob
  queue_as :default

  def perform(image_id, force = false)
    image = Image.find_by(id: image_id)
    return if image.nil? || image.image_data.nil?

    if image.image_derivatives.blank? || force
      image.image_derivatives!
      image.save!
    end
  end
end
