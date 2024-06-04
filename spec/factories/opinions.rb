FactoryBot.define do
  factory :opinion do
    association :rater, factory: :user
    association :ratee, factory: :user
    stars { rand(1..5) }
    comment { "Great work!" }
  end
end