class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory, class_name: "Category", optional: true

  has_many :bookings, dependent: :destroy
  has_many_attached :images
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :title, presence: { message: I18n.t('activerecord.errors.models.post.attributes.title.blank') }
  validates :description, presence: { message: I18n.t('activerecord.errors.models.post.attributes.description.blank') }
  validates :price, presence: { message: I18n.t('activerecord.errors.models.post.attributes.price.blank') }
  validates :category_id, presence: { message: I18n.t('activerecord.errors.models.post.attributes.category_id.blank') }

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
