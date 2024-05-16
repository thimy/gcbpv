FactoryBot.define do
  factory :payment do
    payment_method { 1 }
    amount { "9.99" }
    SubscriptionGroup { nil }
    comment { "MyText" }
  end
end
