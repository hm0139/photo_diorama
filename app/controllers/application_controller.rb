class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :name, :reading_name, :postal_code, :prefectures, :city, :building_name, :financial_institution, :branch, :deposit, :account_number, :account_holder])
  end
end
