class ApplicationController < ActionController::Base
  include PowerTypes::Presentable

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    flash[:alert] = I18n.t('controllers.application_controller.not_found_message')
    redirect_to root_path
  end
end
