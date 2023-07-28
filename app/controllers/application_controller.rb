class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_current_notifications

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :name, :reading_name, :postal_code, :prefectures, :city, :building_name, :kind, :financial_institution, :branch, :deposit, :account_number, :account_holder])
  end

  def get_current_notifications
    @notification_count = Notification.where(user_id: current_user.id).count if user_signed_in?
  end
end
