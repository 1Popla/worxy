class Opinion < ApplicationRecord
  belongs_to :rater, class_name: "User"
  belongs_to :ratee, class_name: "User"

  validates :stars, presence: true, inclusion: {in: 1..5}
  validates :rater_id, uniqueness: {scope: :ratee_id, message: "You can only give one opinion to a user."}
end
