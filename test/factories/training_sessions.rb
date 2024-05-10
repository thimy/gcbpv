FactoryBot.define do
  factory :training_session do
    name { "MyString" }
    description { "MyText" }
    training { nil }
    date { "2024-05-10" }
    start_time { "MyText" }
    end_time { "MyText" }
  end
end
