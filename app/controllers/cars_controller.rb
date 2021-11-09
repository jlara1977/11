class CarsController < ApplicationController
  def index
    @cars = Car.active.includes(:price_versions, model: :brand)
    @brands = Brand.active.includes(:image)
    @models = Model.active_and_sorted_by_minimum_price.includes(:brand, :technical_file)
    @shift_options = EnumUtils.enum_options_for_select_in_vue(Car, :shift)
    @fuel_options = EnumUtils.enum_options_for_select_in_vue(Car, :fuel).sort_by { |o| o[:value] }
    @traction_options = EnumUtils.enum_options_for_select_in_vue(Car, :traction)
    @annual_distance_options = PriceVersion.annual_distances.keys
    @contract_time_options = PriceVersion.contract_times.keys
    @car_type_options = EnumUtils.enum_options_for_select_in_vue(Model, :car_type)
    @filter_brand = permitted_params[:brand_id].present? ? filter_brand : nil
  end

  private

  def permitted_params
    params.permit(:brand_id)
  end

  def filter_brand
    @filter_brand ||= Brand.find(permitted_params[:brand_id])
  end
end
