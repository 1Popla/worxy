class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: {message: "Cannot send empty message"}

  after_create_commit do
    broadcast_append_to conversation, target: "messages", partial: "messages/message", locals: { message: self, current_user_id: user_id }
  end
end
