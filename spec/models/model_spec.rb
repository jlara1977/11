require 'rails_helper'

RSpec.describe Model, type: :model do
  it "has a valid factory" do
    expect(build(:model)).to be_valid
  end

  describe "associations" do
    it { is_expected.to belong_to(:brand) }
    it { is_expected.to have_many(:cars) }
    it { is_expected.to have_many(:price_versions) }
    it { is_expected.to have_many(:images) }
    it { is_expected.to have_many(:characteristings) }
    it { is_expected.to have_many(:characteristics) }
  end

  describe '#max_prioritized_display' do
    let(:max_prioritized_models) { '3' }

    before do
      allow(ENV).to receive(:[]).with('MAX_PRIORITIZED_MODELS').and_return(max_prioritized_models)
    end

    context "when there is less than 'MAX_PRIORITIZED_MODELS'" do
      let!(:models) { create_list(:model, max_prioritized_models.to_i, prioritized_display: true) }
      let(:non_prioritized_model) { create(:model) }

      it 'expects to raise' do
        expect do
          non_prioritized_model.update!(prioritized_display: true)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
