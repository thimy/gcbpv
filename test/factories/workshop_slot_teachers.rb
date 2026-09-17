# == Schema Information
#
# Table name: workshop_slot_teachers
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  teacher_id       :bigint           not null
#  workshop_slot_id :bigint           not null
#
# Indexes
#
#  index_workshop_slot_teachers_on_teacher_id        (teacher_id)
#  index_workshop_slot_teachers_on_workshop_slot_id  (workshop_slot_id)
#
# Foreign Keys
#
#  fk_rails_...  (teacher_id => teachers.id)
#  fk_rails_...  (workshop_slot_id => workshop_slots.id)
#
FactoryBot.define do
  factory :workshop_slot_teacher do
    teacher { nil }
    workshop_slot { nil }
  end
end
