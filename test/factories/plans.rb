FactoryBot.define do
  factory :plan do
    class_price { "9.99" }
    kids_class_price { "9.99" }
    workshop_price { "9.99" }
    obc_markup { 1 }
    outbounds_markup { 1 }
  end
end
