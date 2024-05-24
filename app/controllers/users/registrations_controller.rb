class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def new
    super do
      @skills = Rails.configuration.x.app_data[:skills]
      @locations = Rails.configuration.x.app_data[:locations]
      @experience_levels = Rails.configuration.x.app_data[:experience_levels]
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number, :role, :country_code, :first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone_number, :role, :country_code, :first_name, :last_name])
  end

  def after_sign_up_path_for(resource)
    new_user_steps_path(resource)
  end
end
