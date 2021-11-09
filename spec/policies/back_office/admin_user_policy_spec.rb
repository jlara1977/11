describe BackOffice::AdminUserPolicy do
  subject(:policy) { described_class }

  let(:admin_user_one) { create(:admin_user) }
  let(:admin_user_two) { create(:admin_user) }

  permissions :index?, :show?, :create?, :new?, :destroy? do
    it { expect(policy).to permit(admin_user_one, admin_user_two)  }
  end

  permissions :update?, :edit? do
    it { expect(policy).to permit(admin_user_one, admin_user_one)  }
    it { expect(policy).not_to permit(admin_user_one, admin_user_two)  }
  end
end
