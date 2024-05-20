class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :conversations, foreign_key: :sender_id, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :booked_services, through: :posts, source: :bookings

  enum role: { worker: 0, customer: 1 }

  validates :role, presence: true
end
