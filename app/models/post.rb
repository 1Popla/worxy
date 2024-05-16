class Post < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :images

  validates :title, :description, :price, :service_category, presence: true

  enum status: {draft: 0, pending: 1, active: 2, archived: 3}

  scope :active, -> { where(status: :active) }

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def address
    [street, city, state, country].compact.join(", ")
  end

  def address_changed?
    street_changed? || city_changed? || state_changed? || country_changed?
  end
end
