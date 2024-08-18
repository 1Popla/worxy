class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @active_conversations = Conversation.for_belonging_user(current_user.id)
    @selectable_users = selectable_users
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
    @new_message = @conversation.messages.new
  end

  def create_or_open
    sender_id = current_user.id
    recipient_id = params[:recipient_id]

    @conversation = Conversation.between(sender_id, recipient_id).first_or_initialize(sender_id: sender_id, recipient_id: recipient_id)

    if @conversation.new_record?
      @conversation.save
    end

    redirect_to conversation_messages_path(@conversation)
  end

  def create
    sender_id = current_user.id
    recipient_id = conversation_params[:recipient_id]

    @conversation = Conversation.between(sender_id, recipient_id).first_or_initialize(sender_id: sender_id, recipient_id: recipient_id)

    if @conversation.save
      redirect_to conversation_messages_path(@conversation)
    else
      flash[:alert] = @conversation.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def search_users
    @page = [params[:page].to_i, 1].max
    @per_page = 10
  
    if params[:query].present?
      @users = User.where("first_name ILIKE ? OR last_name ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
                   .offset((@page - 1) * @per_page)
                   .limit(@per_page)
    else
      @users = User.none
    end
  
    respond_to do |format|
      format.turbo_stream do
        render partial: 'conversations/users_list', locals: { users: @users }, formats: :html
      end
    end
  end
  

  private

  def conversation_params
    params.require(:conversation).permit(:recipient_id)
  end

  def selectable_users
    user_ids_with_conversations = Conversation.for_belonging_user(current_user.id).pluck(:sender_id, :recipient_id).flatten.uniq - [current_user.id]

    booking_user_ids = Booking.where(user_id: current_user.id).pluck(:visible_to_user_id) +
      Booking.joins(:post).where(posts: {user_id: current_user.id}).pluck(:user_id) +
      Booking.where(visible_to_user_id: current_user.id).pluck(:user_id)

    user_ids_with_bookings = booking_user_ids.flatten.uniq - [current_user.id]

    User.where(id: (user_ids_with_conversations + user_ids_with_bookings).uniq).distinct
  end
end
