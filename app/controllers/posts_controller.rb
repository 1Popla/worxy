class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
    @posts = Post.all
    @customer_posts = Post.joins(:user).where(users: { role: 'customer' }).page(params[:page]).per(10)
    @worker_posts = Post.joins(:user).where(users: { role: 'worker' }).page(params[:page]).per(10)

    if params[:category].present?
      @customer_posts = @customer_posts.where(category_id: params[:category])
      @worker_posts = @worker_posts.where(category_id: params[:category])
    end

    if params[:search].present?
      @customer_posts = @customer_posts.where("title ILIKE ? OR description ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      @worker_posts = @worker_posts.where("title ILIKE ? OR description ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    respond_to do |format|
      format.html
      format.json { render json: params[:tab] == 'worker' ? @worker_posts : @customer_posts }
    end
  end

  def user_posts
    @user_posts = current_user.posts.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.json { render json: @user_posts }
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
