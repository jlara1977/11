class LandingController < ApplicationController
  def index
    @brands = Brand.active.for_landing.includes(:image)
  end
end
