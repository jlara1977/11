class CarModelRequestMailer < ApplicationMailer
  DEFAULT_EMAIL_ADDRESS = ENV.fetch('DEFAULT_EMAIL_ADDRESS', 'contacto@nexcar.cl')

  default from: "Nexcar <#{DEFAULT_EMAIL_ADDRESS}>"

  def received
    @car_model_request = params[:car_model_request]
    email = @car_model_request.email
    mail to: [email, DEFAULT_EMAIL_ADDRESS]
  end
end
