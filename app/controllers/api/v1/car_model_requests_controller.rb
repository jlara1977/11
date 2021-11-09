class Api::V1::CarModelRequestsController < Api::V1::BaseController
  def create
    car_model_request = CarModelRequest.create!(permitted_params)
    respond_with car_model_request
  end

  private

  def permitted_params
    params[:car_model_request].permit(:email, :brand, :model, :annual_distance, :contract_time,
                                      :first_name, :last_name, :comment, :phone_number)
  end
end
