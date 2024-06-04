FactoryBot.define do
  factory :post do
    association :user
    association :category
    title { "Test Title" }
    description { "Test Description" }
    price { 100.0 }
  end
end