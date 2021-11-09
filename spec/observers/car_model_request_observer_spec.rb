require 'rails_helper'

describe CarModelRequestObserver do
  let(:car_model_request) { create(:car_model_request) }
  let(:car_model_request_mailer) do
    instance_double('CarModelRequestMailer', received: message_delivery)
  end
  let(:message_delivery) do
    instance_double('ActionMailer::MessageDelivery', deliver_later: nil)
  end

  def trigger(type, event)
    described_class.trigger(type, event, car_model_request)
  end

  describe '#send_received_reservation_email' do
    before do
      allow(CarModelRequestMailer).to receive(:with).and_return(car_model_request_mailer)
    end

    it 'calls CarModelRequestMailer with car_model_request and delivers_later' do
      trigger :after, :create
      expect(
        CarModelRequestMailer
      ).to have_received(:with).with(car_model_request: car_model_request)
      expect(car_model_request_mailer).to have_received(:received)
      expect(message_delivery).to have_received(:deliver_later)
    end
  end
end
