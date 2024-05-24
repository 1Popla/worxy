class UserStepsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
  end

  def create
    @user = current_user
    if @user.update(user_params)
      redirect_to dashboard_index_path, notice: 'Profile updated successfully.'
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to dashboard_index_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:description, :skills, :location, :experience)
  end
end
