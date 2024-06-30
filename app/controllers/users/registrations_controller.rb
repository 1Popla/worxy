class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_app_data, only: [:new, :edit, :update]

  def new
    super do
      @skills = Rails.configuration.x.app_data[:skills]
      @locations = Rails.configuration.x.app_data[:locations]
      @experience_levels = Rails.configuration.x.app_data[:experience_levels]
    end
  end

  def edit
    super do
      @skills = Rails.configuration.x.app_data[:skills]
      @locations = Rails.configuration.x.app_data[:locations]
      @experience_levels = Rails.configuration.x.app_data[:experience_levels]
    end
  end

  def update
    super do
      @skills = Rails.configuration.x.app_data[:skills]
      @locations = Rails.configuration.x.app_data[:locations]
      @experience_levels = Rails.configuration.x.app_data[:experience_levels]
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number, :role, :country_code, :first_name, :last_name, :description, :skills, :location, :experience])
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone_number, :role, :country_code, :first_name, :last_name, :description, :skills, :location, :experience])
  end

  def after_sign_up_path_for(resource)
    resource.role == 'customer' ? dashboard_index_path : new_user_steps_path(resource)
  end

  def after_update_path_for(resource)
    dashboard_index_path
  end

  private

  def set_app_data
    @skills = Rails.configuration.x.app_data[:skills]
    @locations = Rails.configuration.x.app_data[:locations]
    @experience_levels = Rails.configuration.x.app_data[:experience_levels]
  end
end
