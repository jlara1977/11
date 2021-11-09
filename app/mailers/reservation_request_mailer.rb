class ReservationRequestMailer < ApplicationMailer
  DEFAULT_EMAIL_ADDRESS = ENV.fetch('DEFAULT_EMAIL_ADDRESS', 'contacto@nexcar.cl')

  default from: "Nexcar <#{DEFAULT_EMAIL_ADDRESS}>"

  def received
    @reservation_request = params[:reservation_request]
    @car = @reservation_request.car
    @price_version = @reservation_request.price_version
    email = @reservation_request.email
    mail to: [email, DEFAULT_EMAIL_ADDRESS]
  end
end
