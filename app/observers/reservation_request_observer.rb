class ReservationRequestObserver < PowerTypes::Observer
  after_create :send_reservation_email

  def send_reservation_email
    ReservationRequestMailer.with(reservation_request: object).received.deliver_later
  end
end
