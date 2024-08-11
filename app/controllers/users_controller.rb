class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:show]

  def show
  end

  def avatar_upload
    if current_user.id == params[:user][:id].to_i
      if current_user.update(avatar_params)
        flash[:notice] = "Avatar updated successfully."
      else
        flash[:alert] = "Failed to update avatar."
      end
    else
      flash[:alert] = "You are not authorized to update this avatar."
    end
    redirect_to request.referrer || root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def avatar_params
    params.require(:user).permit(:avatar)
  end
end
