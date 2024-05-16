class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :visible_to_user, class_name: "User", optional: true

  enum status: {pending: 0, confirmed: 1, completed: 2, cancelled: 3}

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
