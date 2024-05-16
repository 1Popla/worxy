class Post < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :images

  validates :title, :description, presence: true

  enum status: {draft: 0, pending: 1, active: 2, archived: 3}

  scope :active, -> { where(status: :active) }
end
