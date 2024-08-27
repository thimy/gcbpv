class KidWorkshop < ApplicationRecord
  has_many :kid_workshop_slots
  has_many :subbed_kid_workshops, through: :kid_workshop_slots
  has_many :subscriptions, through: :subbed_kid_workshops
  has_many :cities, through: :kid_workshop_slots

  accepts_nested_attributes_for :kid_workshop_slots

  enum :workshop_type, "Éveil" => 0, "Découverte" => 1, "Parent-Enfant" => 2
  enum :status, "Public" => 0, "Privé" => 1

  scope :active, -> { where(status: 0) }

  def student_count
    students_by_slot.join(", ")
  end

  def students_by_slot
    SubbedKidWorkshop.joins(:subscription, :kid_workshop_slot).where(kid_workshop_slot: {kid_workshop: self}).group(:kid_workshop_slot_id).count.collect {|id, count|
      slot = KidWorkshopSlot.find_by(id: id)
      "#{slot.city.name} - #{slot.day_of_week} avec #{slot.teacher_names}: #{count}"
    }
  end

  def subscriptions
    SubbedKidWorkshop.joins(:subscription, :kid_workshop_slot).where(kid_workshop_slot: {kid_workshop: self})
  end
end
