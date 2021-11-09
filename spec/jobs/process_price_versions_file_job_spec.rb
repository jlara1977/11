require 'rails_helper'

describe ProcessPriceVersionsFileJob do
  let(:file_url) { '/some_path' }

  def perform
    described_class.perform_now(file_url)
  end

  before do
    allow(ProcessPriceVersionsMatrixFile).to receive(:for).with(file_url: file_url)
  end

  describe '#perform' do
    it 'calls ProcessPriceVersionsMatrixFile command' do
      perform

      expect(ProcessPriceVersionsMatrixFile).to have_received(:for).with(
        file_url: file_url
      ).once
    end
  end
end
