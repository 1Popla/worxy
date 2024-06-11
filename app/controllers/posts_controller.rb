require 'net/http'
require 'json'

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :send_request]
  before_action :authenticate_user!, only: [:send_request]

  def index
    @categories = Category.all
    @posts = Post.all
    @customer_posts = Post.joins(:user).where(users: { role: "customer" }).page(params[:page]).per(10)
    @worker_posts = Post.joins(:user).where(users: { role: "worker" }).page(params[:page]).per(10)

    if params[:category].present?
      @customer_posts = @customer_posts.where(category_id: params[:category])
      @worker_posts = @worker_posts.where(category_id: params[:category])
    end

    if params[:search].present?
      @customer_posts = @customer_posts.where("posts.title ILIKE ? OR posts.description ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      @worker_posts = @worker_posts.where("posts.title ILIKE ? OR posts.description ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    respond_to do |format|
      format.html
      format.json { render json: (params[:tab] == "worker") ? @worker_posts : @customer_posts }
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

  def send_request
    if current_user.worker? || current_user.customer?
      Notification.create(
        recipient: @post.user,
        actor: current_user,
        action: "sent you a request for",
        notifiable: @post,
        message: params[:message],
        price_offer: params[:price_offer],
        start_date_offer: params[:start_date_offer]
      )
      redirect_to @post, notice: "Propozycja wysłana do klienta pomyślnie."
    else
      redirect_to @post, alert: "Nie masz uprawnień do wysyłania propozycji."
    end
  end

  def generate_description
    user = User.find(params[:user_id])
    description = generate_description_for(user)

    render json: { description: description }
  end

  private

  def generate_description_for(user)
    skills = user.skills.is_a?(Array) ? user.skills.join(', ') : user.skills

    user_data = {
      name: user.first_name,
      skills: skills,
      experience: user.experience,
      description: user.description
    }

    prompt = <<~PROMPT
      Wygeneruj szczegółowy i złożony opis posta po polsku, jakby użytkownik opisywał siebie. 
      Opis powinien podkreślać umiejętności i doświadczenie użytkownika, 
      a także oferować usługi zgodnie z umiejętnościami użytkownika. Zapamiętaj aby nie używać zdrobnień i opis musi posiadać poważny ton. Oto dane użytkownika: #{user_data.to_json}
    PROMPT

    uri = URI("https://api.llama-api.com/chat/completions")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request_body = {
      messages: [
        { role: "user", content: prompt }
      ],
      stream: false,
      max_tokens: 2048
    }.to_json

    request = Net::HTTP::Post.new(uri.path, {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{ENV['LLAMA_API_KEY']}"
    })
    request.body = request_body

    Rails.logger.debug("API request body: #{request_body}")

    response = http.request(request)
    response_body = response.body
    Rails.logger.debug("API response: #{response_body}")

    if response_body.empty?
      Rails.logger.error("Empty API response")
      return "Błąd podczas generowania opisu. Proszę spróbować ponownie."
    end

    result = JSON.parse(response_body)

    if result && result["choices"] && result["choices"][0] && result["choices"][0]["message"]
      return result["choices"][0]["message"]["content"]
    else
      Rails.logger.error("Unexpected API response structure: #{response_body}")
      return "Błąd podczas generowania opisu. Proszę spróbować ponownie."
    end
  rescue => e
    Rails.logger.error("Error generating description: #{e.message}")
    "Błąd podczas generowania opisu. Proszę spróbować ponownie."
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :price, :availability, :contact_information, :status, :latitude, :message, :longitude, :street, :city, :state, :country, :category_id, images: [])
  end
end
