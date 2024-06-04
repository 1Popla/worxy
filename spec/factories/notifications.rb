FactoryBot.define do
  factory :notification do
    association :recipient, factory: :user
    association :actor, factory: :user
    action { "MyString" }
    association :notifiable, factory: :opinion
  end
end
