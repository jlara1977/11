require 'rails_helper'

RSpec.describe ModelsController, type: :controller do
  let(:model) { create(:model) }

  describe "GET #index" do
    context 'when model is found' do
      before do
        get :show, params: { id: model.id }
      end

      it { expect(response.status).to eq(200) }
    end
  end
end
