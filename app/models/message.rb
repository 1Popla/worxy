class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: { message: "Cannot send an empty message" }

  after_create_commit do
    broadcast_append_later_to "#{conversation.id}_#{user_id}",
                              target: "messages",
                              partial: "messages/message",
                              locals: { message: self, current_user_id: user_id }

    recipient_id = conversation.sender_id == user_id ? conversation.recipient_id : conversation.sender_id
    broadcast_append_later_to "#{conversation.id}_#{recipient_id}",
                              target: "messages",
                              partial: "messages/message",
                              locals: { message: self, current_user_id: recipient_id }
  end
end
