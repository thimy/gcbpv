FactoryBot.define do
  factory :workshop_slot do
    workshop { nil }
    city { nil }
    start_time { "MyString" }
    end_time { "MyString" }
    day_of_week { 1 }
  end
end
