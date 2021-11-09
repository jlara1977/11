class CarModelRequestObserver < PowerTypes::Observer
  after_create :send_received_reservation_email

  def send_received_reservation_email
    CarModelRequestMailer.with(car_model_request: object).received.deliver_later
  end
end
