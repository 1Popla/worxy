class PortfolioImagesController < ApplicationController
  before_action :set_user

  def new
  end

  def create
    if params[:user][:portfolio_images]
      @user.portfolio_images.attach(params[:user][:portfolio_images])
      redirect_to @user, notice: 'Images uploaded successfully.'
    else
      flash.now[:alert] = 'Please select images to upload.'
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
