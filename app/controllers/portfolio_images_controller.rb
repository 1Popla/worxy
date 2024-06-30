class PortfolioImagesController < ApplicationController
  before_action :set_user

  def new
  end

  def create
    if params[:user][:portfolio_images]
      @user.portfolio_images.attach(params[:user][:portfolio_images])
      redirect_to @user, notice: "Images uploaded successfully."
    else
      flash.now[:alert] = "Please select images to upload."
      render :new
    end
  end

  def destroy
    @image = @user.portfolio_images.find(params[:id])
    @image.purge

    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: "Image was successfully deleted." }
      format.turbo_stream { render turbo_stream: turbo_stream.remove("image-container-#{@image.id}") }
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
