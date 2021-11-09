class BackOffice::ActiveAdmin::PagePolicy < BackOffice::DefaultPolicy
  def show?
    true
  end
end
