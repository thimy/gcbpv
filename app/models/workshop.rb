class Workshop < ApplicationRecord
  include WithTime

  has_and_belongs_to_many :teachers
  has_many :workshop_slots
  has_many :subbed_workshops, through: :workshop_slots
  has_many :subscriptions, through: :subbed_workshops
  has_many :cities, through: :workshop_slots
  belongs_to :price_category
  has_many :plan_price_categories, through: :price_category

  accepts_nested_attributes_for :workshop_slots, :plan_price_categories

  validates :name, presence: true

  enum :status, "Public" => 0, "Privé" => 1

  scope :active, -> {where(status: 0)}
  scope :youth, ->{where(is_youth: true)}
  scope :adults, ->{where(is_youth: nil)}

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
