describe BackOffice::DefaultPolicy do
  subject(:policy) { described_class }

  let(:admin_user) { create(:admin_user) }

  permissions :index?, :show?, :create?, :new?, :update?, :edit?, :destroy? do
    it { expect(policy).to permit(admin_user, nil)  }
  end
end
