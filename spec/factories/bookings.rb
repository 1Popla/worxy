FactoryBot.define do
  factory :booking do
    association :user
    association :post
    start_date { Date.today }
    end_date { Date.today + 1.day }
    status { :pending }

    factory :booking_with_visible_user do
      association :visible_to_user, factory: :user
    end
  end
end
