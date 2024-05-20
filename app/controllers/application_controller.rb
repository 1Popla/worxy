class ApplicationController < ActionController::Base
  helper RoleHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(_resource)
    dashboard_index_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number, :role, :country_code])
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone_number, :role, :country_code])
  end
end
