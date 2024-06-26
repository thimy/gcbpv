
slots = [
  {
    teacher_id: 1,
    city_id: 1,
    day_of_week: 1,
    slot_time: "16h"
  },
  {
    teacher_id: 1,
    city_id: 2,
    day_of_week: 3,
    slot_time: "15h"
  },
  {
    teacher_id: 1,
    city_id: 2,
    day_of_week: 3,
    slot_time: "18h45"
  },
  {
    teacher_id: 1,
    city_id: 4,
    day_of_week: 4,
    slot_time: "16h"
  },
  {
    teacher_id: 1,
    city_id: 4,
    day_of_week: 4,
    slot_time: "18h45"
  },
  {
    teacher_id: 1,
    city_id: 5,
    day_of_week: 3,
    slot_time: "11h"
  },
  {
    teacher_id: 2,
    city_id: 1,
    day_of_week: 1,
    slot_time: "12h"
  },
  {
    teacher_id: 2,
    city_id: 1,
    day_of_week: 1,
    slot_time: "19h30"
  },
  {
    teacher_id: 2,
    city_id: 1,
    day_of_week: 4,
    slot_time: "15h30"
  },
  {
    teacher_id: 2,
    city_id: 1,
    day_of_week: 4,
    slot_time: "17h45"
  },
  {
    teacher_id: 2,
    city_id: 1,
    day_of_week: 4,
    slot_time: "19h45"
  },
  {
    teacher_id: 2,
    city_id: 7,
    day_of_week: 1,
    slot_time: "16h30"
  },
  {
    teacher_id: 3,
    city_id: 1,
    day_of_week: 3,
    slot_time: "16h"
  },
  {
    teacher_id: 3,
    city_id: 6,
    day_of_week: 3,
    slot_time: "17h"
  },
  {
    teacher_id: 4,
    city_id: 1,
    day_of_week: 3,
    slot_time: "9h"
  },
  {
    teacher_id: 5,
    city_id: 4,
    day_of_week: 3,
    slot_time: "17h45"
  },
  {
    teacher_id: 6,
    city_id: 1,
    day_of_week: 3,
    slot_time: "9h30"
  },
  {
    teacher_id: 6,
    city_id: 2,
    day_of_week: 3,
    slot_time: "16h20"
  },
  {
    teacher_id: 6,
    city_id: 3,
    day_of_week: 2,
    slot_time: "16h30"
  },
  {
    teacher_id: 6,
    city_id: 4,
    day_of_week: 3,
    slot_time: "14h"
  },
  {
    teacher_id: 6,
    city_id: 7,
    day_of_week: 1,
    slot_time: "18h"
  },
  {
    teacher_id: 7,
    city_id: 4,
    day_of_week: 4,
    frequency: 3
  },
  {
    teacher_id: 7,
    city_id: 10,
    day_of_week: 3,
    frequency: 2
  },
  {
    teacher_id: 8,
    city_id: 1,
    day_of_week: 3,
    slot_time: "19h"
  },
  {
    teacher_id: 8,
    city_id: 9,
    day_of_week: 3,
    slot_time: "19h"
  },
  {
    teacher_id: 8,
    city_id: 2,
    day_of_week: 3,
    slot_time: "17h"
  },
  {
    teacher_id: 9,
    city_id: 1,
    day_of_week: 1,
    slot_time: "16h"
  },
  {
    teacher_id: 9,
    city_id: 10,
    day_of_week: 3,
    frequency: 3
  },
  {
    teacher_id: 10,
    city_id: 1,
    day_of_week: 3,
  },
  {
    teacher_id: 11,
    city_id: 1,
    day_of_week: 2,
    slot_time: "9h"
  },
  {
    teacher_id: 11,
    city_id: 1,
    day_of_week: 2,
    slot_time: "16h"
  },
  {
    teacher_id: 11,
    city_id: 2,
    day_of_week: 3,
    slot_time: "14h30"
  },
  {
    teacher_id: 12,
    city_id: 1,
    day_of_week: 5,
    frequency: 1
  },
  {
    teacher_id: 12,
    city_id: 4,
  },
  {
    teacher_id: 12,
    city_id: 6,
  },
  {
    teacher_id: 13,
    city_id: 7,
    day_of_week: 1,
    slot_time: "16h30"
  },
  {
    teacher_id: 14,
    city_id: 1,
    day_of_week: 2,
    slot_time: "14h30"
  },
  {
    teacher_id: 14,
    city_id: 1,
    day_of_week: 4,
    slot_time: "14h30"
  },
  {
    teacher_id: 14,
    city_id: 8,
    day_of_week: 2,
    slot_time: "14h30"
  },
  {
    teacher_id: 14,
    city_id: 8,
    day_of_week: 4,
    slot_time: "14h30"
  },
  {
    teacher_id: 15,
    city_id: 1,
    day_of_week: 3,
    slot_time: "14h"
  },
  {
    teacher_id: 16,
    city_id: 2,
    day_of_week: 2,
    slot_time: "18h"
  },
  {
    teacher_id: 16,
    city_id: 2,
    day_of_week: 3,
    slot_time: "18h"
  },
]

slots.each do |slot|
  Slot.create!(slot)
end
