class Api::V1::ReservationRequestsController < Api::V1::BaseController
  def create
    requeset_reservation = ReservationRequest.create!(permitted_params)
    respond_with requeset_reservation
  end

  private

  def permitted_params
    params[:reservation_request].permit(:car_id, :price_version_id, :email, :first_name, :last_name,
                                        :contact_number, :kind, :comment)
  end
end
