class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_app_data, only: [:new, :edit, :update]

  def new
    super do
      set_form_data
    end
  end

  def create
    build_resource(sign_up_params)
  
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        flash[:notice] = 'Wysłano link weryfikacyjny na twój email.'
        redirect_to new_user_registration_path
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        flash[:notice] = 'Wysłano link weryfikacyjny na twój email.'
        redirect_to new_user_registration_path
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def edit
    super do
      set_form_data
    end
  end

  def update
    super do
      set_form_data
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number, :role, :country_code, :first_name, :last_name, :description, :skills, :location, :experience])
    devise_parameter_sanitizer.permit(:account_update, keys: [:phone_number, :role, :country_code, :first_name, :last_name, :description, :skills, :location, :experience])
  end

  def after_update_path_for(resource)
    posts_path
  end

  private

  def set_app_data
    @skills = Rails.configuration.x.app_data[:skills]
    @locations = Rails.configuration.x.app_data[:locations]
    @experience_levels = Rails.configuration.x.app_data[:experience_levels]
  end

  def set_form_data
    @skills = Rails.configuration.x.app_data[:skills]
    @locations = Rails.configuration.x.app_data[:locations]
    @experience_levels = Rails.configuration.x.app_data[:experience_levels]
  end
end
