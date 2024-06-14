class KidWorkshopSlotTeacher < ApplicationRecord
  belongs_to :teacher
  belongs_to :kid_workshop_slot
end
