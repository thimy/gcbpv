class Workshop < ApplicationRecord
  include WithTime

  has_and_belongs_to_many :teachers
  has_many :workshop_slots
  has_many :cities, through: :workshop_slots

  accepts_nested_attributes_for :workshop_slots

  validates :name, presence: true

  enum :status, "Public" => 0, "Privé" => 1
  enum :workshop_type, "Normal" => 0, "Spécial" => 1

  scope :active, -> {where(status: 0)}

  def student_count
    SubbedWorkshop.joins(:subscription, :workshop_slot).where(workshop_slot: {workshop: self}).group(:workshop_slot_id).count.map {|id, count|
      slot = WorkshopSlot.find_by(id: id)
      "#{slot.city.name} - #{slot.day_of_week} avec #{slot.teacher_names}: #{count}"
    }.join(", ")
  end
end
