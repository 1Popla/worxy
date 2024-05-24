FactoryBot.define do
  factory :user do
    first_name { "Test" }
    last_name { "Tested" }
    sequence(:email) { |n| "test#{n}@test.com" }
    password { "testtest123" }
    password_confirmation { "testtest123" }
    phone_number { "1234567890" }
    country_code { "+48" }
    role { :worker }
  end
end
