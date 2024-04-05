class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @active_conversations = Conversation.for_belonging_user(current_user.id)
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
    @new_message = @conversation.messages.new
  end

  def create
    sender_id = current_user.id
    recipient_id = conversation_params[:recipient_id]

    @conversation = Conversation.between(sender_id, recipient_id).first_or_create(sender_id: sender_id, recipient_id: recipient_id)

    if @conversation.persisted?
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
end
