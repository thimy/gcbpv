FactoryBot.define do
  factory :kid_workshop_slot do
    kid_workshop { nil }
    city { nil }
    slot_time { "MyString" }
    day_of_week { 1 }
    frequency { 1 }
  end
end
