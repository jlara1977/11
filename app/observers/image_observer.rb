class ImageObserver < PowerTypes::Observer
  after_save :create_derivatives

  def create_derivatives
    GenerateImageDerivativesJob.perform_later(object.id)
  end
end
