class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :visible_to_user, class_name: "User", optional: true

  enum status: {pending: 0, confirmed: 1, completed: 2, cancelled: 3}
end