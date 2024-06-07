class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :conversations, foreign_key: :sender_id, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :booked_services, through: :posts, source: :bookings

  enum role: {worker: 0, customer: 1}

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true
  validates :phone_number, presence: true, length: {minimum: 9}
  validates :country_code, presence: true

  has_many :sent_notifications, class_name: "Notification", foreign_key: :actor_id, dependent: :destroy
  has_many :received_notifications, class_name: "Notification", foreign_key: :recipient_id, dependent: :destroy

  has_many :given_opinions, class_name: "Opinion", foreign_key: :rater_id, dependent: :destroy
  has_many :received_opinions, class_name: "Opinion", foreign_key: :ratee_id, dependent: :destroy

  def average_rating
    return nil if received_opinions.empty?
    avg = received_opinions.average(:stars).round(2)
    (avg % 1 == 0) ? avg.to_i : avg
  end
end
