FactoryBot.define do
  factory :notification do
    recipient { nil }
    actor { nil }
    action { "MyString" }
    notifiable { nil }
  end
end
