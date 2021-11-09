class BackOffice::ReservationRequestPolicy < BackOffice::DefaultPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    true
  end

  def destroy?
    true
  end
end
