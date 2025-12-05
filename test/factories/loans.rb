FactoryBot.define do
  factory :loan do
    instrument { "MyString" }
    subscription { nil }
    cost { "9.99" }
  end
end
