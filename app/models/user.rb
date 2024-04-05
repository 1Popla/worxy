class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :conversations, foreign_key: :sender_id
  has_many :messages

  enum role: %w[worker customer]
end
