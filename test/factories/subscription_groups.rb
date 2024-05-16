FactoryBot.define do
  factory :subscription_group do
    amount_paid { "9.99" }
    comment { "MyText" }
    payor { nil }
  end
end
