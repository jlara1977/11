class BackOffice::AdminUserPolicy < BackOffice::DefaultPolicy
  def update?
    @user.id == @record.id
  end
end
