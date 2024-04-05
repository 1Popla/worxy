class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation

  def index
    set_active_conversations_with_recipients
    @messages = @conversation.messages.page(params[:page]).per(20)
    @new_message = @conversation.messages.new
  end

  def create
    @new_message = @conversation.messages.new(message_params.merge(user_id: current_user.id))

    if @new_message.save
      respond_to do |format|
        format.html { redirect_to conversation_messages_path(@conversation) }
      end
    else
      set_active_conversations_with_recipients
      @messages = @conversation.messages.page(params[:page]).per(20)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("message_form_errors", partial: "messages/form_errors", locals: {message: @new_message})
        end
        format.html do
          flash.now[:alert] = @new_message.errors.full_messages.to_sentence
          render "index"
        end
      end
    end
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
end
