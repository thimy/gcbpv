FactoryBot.define do
  factory :plan_price_category do
    plan { nil }
    price_category { nil }
    price { "9.99" }
    obc_price { "9.99" }
    outbounds { "9.99" }
  end
end
