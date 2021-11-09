require 'rails_helper'

describe ImageObserver do
  let(:model) { create(:model) }
  let(:image) { model.images.create! }

  def trigger(type, event)
    described_class.trigger(type, event, image)
  end

  describe '#create_derivatives' do
    context 'when image is saved' do
      it 'calls GenerateImageDerivatesJob' do
        trigger(:after, :save)
        expect(GenerateImageDerivativesJob).to have_been_enqueued.with(image.id)
      end
    end
  end
end
