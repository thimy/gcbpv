class KidWorkshopSlotTeacher < ApplicationRecord
  belongs_to :teacher
  belongs_to :kid_workshop_slot

  validates :teacher, presence: true
  validates :kid_workshop_slot, presence: true
end
