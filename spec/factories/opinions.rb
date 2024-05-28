FactoryBot.define do
  factory :opinion do
    rater_id { 1 }
    ratee_id { 1 }
    stars { 1 }
    comment { "MyText" }
  end
end
