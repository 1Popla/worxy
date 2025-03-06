class ApplicationController < ActionController::Base
  helper RoleHelper
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def after_sign_in_path_for(_resource)
    posts_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number, :role, :country_code, :first_name, :last_name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone_number, :role, :country_code, :first_name, :last_name, :avatar])
  end
end