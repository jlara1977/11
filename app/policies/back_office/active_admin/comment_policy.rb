class BackOffice::ActiveAdmin::CommentPolicy < BackOffice::DefaultPolicy
  def index?
    false
  end
end
