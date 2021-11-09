require 'rails_helper'

describe ReservationRequestObserver do
  let(:reservation_request) { create(:reservation_request) }
  let(:reservation_request_mailer) do
    instance_double('ReservationRequestMailer', received: message_delivery)
  end
  let(:message_delivery) do
    instance_double('ActionMailer::MessageDelivery', deliver_later: nil)
  end

  def trigger(type, event)
    described_class.trigger(type, event, reservation_request)
  end

  describe '#send_reservation_email' do
    before do
      allow(ReservationRequestMailer).to receive(:with).and_return(reservation_request_mailer)
    end

    it 'calls ReservationRequestMailer with reservation_request and delivers_later' do
      trigger :after, :create
      expect(
        ReservationRequestMailer
      ).to have_received(:with).with(reservation_request: reservation_request)
      expect(reservation_request_mailer).to have_received(:received)
      expect(message_delivery).to have_received(:deliver_later)
    end
  end
end
