class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"

  has_many :messages, dependent: :destroy

  validate :unique_conversation_between_users

  scope :between, ->(sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id)
      .or(where(sender_id: recipient_id, recipient_id: sender_id))
  end

  scope :for_belonging_user, ->(user_id) do
    where("sender_id = ? OR recipient_id = ?", user_id, user_id)
  end

  private

  def unique_conversation_between_users
    if new_record? && self.class.between(sender_id, recipient_id).exists?
      errors.add(:base, "Conversation between these users already exists")
    end
  end
end
