class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :conversations, foreign_key: :sender_id
  has_many :messages
  has_many :posts
  has_many :bookings
  has_many :booked_services, through: :posts, source: :bookings

  enum role: %w[worker customer]
end
