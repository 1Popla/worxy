class UserStepsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    load_form_data
  end

  def create
    @user = current_user
    if @user.update(user_params)
      redirect_to dashboard_index_path, notice: 'Profile updated successfully.'
    else
      load_form_data
      render :new
    end
  end

  def edit
    @user = current_user
    load_form_data
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to dashboard_index_path, notice: 'Profile updated successfully.'
    else
      load_form_data
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:description, :skills, :location, :experience)
  end

  def load_form_data
    @skills = Rails.configuration.x.app_data[:skills]
    @locations = Rails.configuration.x.app_data[:locations]
    @experience_levels = Rails.configuration.x.app_data[:experience_levels]
  end
end
