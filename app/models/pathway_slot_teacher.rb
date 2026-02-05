class PathwaySlotTeacher < ApplicationRecord
  belongs_to :pathway_slot
  belongs_to :teacher

  validates :pathway_slot, presence: true
  validates :teacher, presence: true
end
