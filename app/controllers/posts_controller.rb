class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to @post, status: :see_other
    else
      @categories = Category.all
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      @categories = Category.all
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
    @categories = Category.all
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :price, :availability, :contact_information, :status, :latitude, :longitude, :street, :city, :state, :country, :category_id, images: [])
  end
end
