require 'rails_helper'

RSpec.describe GenerateImageDerivativesJob, type: :job do
  let(:model) { create(:model) }
  let(:image) { model.images.create! }

  describe '#perform_now' do
    before do
      image.image = fixture_file_upload(Rails.root.join('spec/support/assets/empty_image.jpg'))
      image.save!
    end

    context 'when there are no prior derivatives' do
      it do
        expect { described_class.perform_now(image.id) }.to change {
          image.reload.image_derivatives
        }.from({}).to(hash_including(:search_view_webp))
      end
    end

    context 'when there are prior derivatives' do
      before do
        image.image_derivatives!
        image.save!
      end

      it do
        expect { described_class.perform_now(image.id) }
          .not_to(change { image.reload.image_derivatives })
      end
    end

    context 'when there are prior derivatives and it is forced' do
      it do
        expect { described_class.perform_now(image.id, true) }
          .to(change { image.reload.image_derivatives[:search_view_webp] })
      end
    end
  end

  describe '#perform_later' do
    it do
      expect { described_class.perform_later(image.id) }.to have_enqueued_job(described_class).once
    end
  end
end
