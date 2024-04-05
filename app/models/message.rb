class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: {message: "Cannot send empty message"}
end
