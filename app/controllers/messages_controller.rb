class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation
  before_action :set_message, only: [:show]

  def index
    set_active_conversations_with_recipients
    @messages = @conversation.messages.page(params[:page]).per(20)
    @new_message = @conversation.messages.new
  end

  def create
    @new_message = @conversation.messages.new(message_params.merge(user_id: current_user.id))

    if @new_message.save
      redirect_to conversation_messages_path(@conversation)
    else
      set_active_conversations_with_recipients
      @messages = @conversation.messages.page(params[:page]).per(20)

      flash.now[:alert] = @new_message.errors.full_messages.to_sentence
      render "index", status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def set_active_conversations_with_recipients
    @active_conversations = Conversation.for_belonging_user(current_user.id)
    @active_conversations_with_recipients = @active_conversations.map do |conversation|
      recipient = (conversation.recipient_id == current_user.id) ? conversation.sender : conversation.recipient
      {conversation: conversation, recipient: recipient}
    end
  end

  def set_conversation
    @conversation = Conversation.find_by(id: params[:conversation_id])
    if @conversation.nil? || !(@conversation.sender_id == current_user.id || @conversation.recipient_id == current_user.id)
      redirect_to root_path
    end
  end

  def message_params
    params.require(:message).permit(:body)
  end

  def set_message
    @message = @conversation.messages.find_by(id: params[:id])
    unless @message
      redirect_to conversation_messages_path(@conversation), alert: 'Message not found'
    end
  end
end
