class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :send_request]
  before_action :authenticate_user!, only: [:send_request]

  require 'httparty'

  def index
    @categories = Category.all
    @posts = Post.all
    @customer_posts = Post.joins(:user).where(users: {role: "customer"}).page(params[:page]).per(10)
    @worker_posts = Post.joins(:user).where(users: {role: "worker"}).page(params[:page]).per(10)

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
    if current_user.worker?
      Notification.create(
        recipient: @post.user,
        actor: current_user,
        action: "sent you a request for",
        notifiable: @post,
        message: params[:message]
      )
      redirect_to @post, notice: "Request sent to customer successfully."
    else
      redirect_to @post, alert: "You are not authorized to send requests."
    end
  end

  def generate_description
    user_data = params.require(:user).permit(:first_name, :last_name, :skills, :experience, :description, :phone_number, :email).to_h

    prompt = <<~PROMPT
      Generate a professional and structured description for a post based on the following user details. Highlight the user's individual strengths, expertise, and personality.

      User details:
      - Name: #{user_data[:first_name]} #{user_data[:last_name]}
      - Skills: #{user_data[:skills]}
      - Experience: #{user_data[:experience]}
      - Personal Description: #{user_data[:description]}
      - Phone: #{user_data[:phone_number]}
      - Email: #{user_data[:email]}

      Please create a unique and engaging description.
    PROMPT

    gpt_response = generate_text_with_llama(prompt)
    
    render json: { description: gpt_response }
  end

  private

  def generate_text_with_llama(prompt, max_tokens = 300)
    headers = {
      'Authorization' => "Bearer #{ENV['LLAMA_API_KEY']}",
      'Content-Type' => 'application/json'
    }
    
    body = {
      model: 'llama-2.7B',
      messages: [
        { role: 'system', content: 'You are a helpful assistant.' },
        { role: 'user', content: prompt }
      ],
      max_tokens: max_tokens,
      temperature: 0.7
    }.to_json

    retries = 0
    max_retries = 5
    delay = 1

    begin
      response = HTTParty.post('https://api.llama.ai/v1/completions', headers: headers, body: body)
      Rails.logger.info("Response: #{response.body}")

      if response.success?
        response_body = JSON.parse(response.body)
        if response_body['choices'] && response_body['choices'][0] && response_body['choices'][0]['message'] && response_body['choices'][0]['message']['content']
          return clean_generated_text(response_body['choices'][0]['message']['content'])
        else
          return "Error: Unexpected response format"
        end
      elsif response.code == 429
        raise "Rate limit reached"
      elsif response.code == 403 && response.parsed_response['error']['code'] == 'insufficient_quota'
        return "Error: You have exceeded your API quota. Please check your plan and billing details."
      else
        return "Error: #{response.code} #{response.message}"
      end
    rescue => e
      if retries < max_retries && e.message == "Rate limit reached"
        retries += 1
        sleep(delay)
        delay *= 2
        retry
      else
        Rails.logger.error("LLAMAService error: #{e.message}")
        return "Error generating description"
      end
    end
  end

  def clean_generated_text(text)
    text.strip
  end

  def post_params
    params.require(:post).permit(:title, :description, :price, :category_id, :availability, :contact_information, :street, :city, :state, :country, :latitude, :longitude, images: [])
  end
end
