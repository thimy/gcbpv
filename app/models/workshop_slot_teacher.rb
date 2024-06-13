class WorkshopSlotTeacher < ApplicationRecord
  belongs_to :teacher
  belongs_to :workshop_slot
end
