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
