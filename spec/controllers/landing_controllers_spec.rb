require 'rails_helper'

RSpec.describe LandingController, type: :controller do
  describe "GET #index" do
    before do
      get :index
    end

    it { expect(response.status).to eq(200) }
  end
end
