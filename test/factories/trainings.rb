FactoryBot.define do
  factory :training do
    name { "MyString" }
    description { "MyText" }
    instrument { "MyText" }
    session_count { 1 }
    price { "9.99" }
  end
end
