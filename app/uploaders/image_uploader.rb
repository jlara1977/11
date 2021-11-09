require 'image_processing/vips'

class ImageUploader < BaseUploader
  plugin :default_url
  plugin :derivatives

  def allowed_types
    @allowed_types ||= %w[image/jpeg image/jpg image/png image/svg+xml image/gif].freeze
  end

  Attacher.default_url do
    base_helpers = ActionController::Base.helpers
    base_helpers.image_url("empty_image.jpg")
  end

  Attacher.derivatives do |original|
    vips = ImageProcessing::Vips.source(original)

    {
      search_view_webp: vips.convert('webp').resize_and_pad!(309, 192, extend: :white)
    }
  end
end
