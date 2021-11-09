class ModelsController < ApplicationController
  def show
    @model = Model.active.includes(cars: :price_versions).find(permited_params[:id])
    @car_versions = @model.cars_sorted_by_minimum_price_cents
    @type_of_clients = ReservationRequest.kinds.keys
  end

  private

  def permited_params
    params.permit(:id)
  end
end
