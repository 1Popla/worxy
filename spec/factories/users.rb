FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@test.com" }
    password { "testtest123" }
    password_confirmation { "testtest123" }
  end
end
