class Workshop < ApplicationRecord
  include WithTime

  has_and_belongs_to_many :teachers
  has_many :workshop_slots
  has_many :subbed_workshops, through: :workshop_slots
  has_many :subscriptions, through: :subbed_workshops
  has_many :cities, through: :workshop_slots

  accepts_nested_attributes_for :workshop_slots

  validates :name, presence: true

  enum :status, "Public" => 0, "Privé" => 1
  enum :workshop_type, "Normal" => 0, "Spécial" => 1, "Autonome" => 2

  scope :active, -> {where(status: 0)}

  def student_count
    students_by_slot.join(", ")
  end

  def students_by_slot
    SubbedWorkshop.joins(:subscription, :workshop_slot).where(workshop_slot: {workshop: self}).group(:workshop_slot_id).count.collect {|id, count|
      slot = WorkshopSlot.find_by(id: id)
      "#{slot.city.name} - #{slot.day_of_week} avec #{slot.teacher_names}: #{count}"
    }
  end

  def subscriptions
    SubbedWorkshop.joins(:subscription, :workshop_slot).where(workshop_slot: {workshop: self})
  end
end
