class Teacher < ApplicationRecord
  phony_normalize :phone, default_country_code: "FR"

  has_many :specialties, dependent: :delete_all
  has_many :instruments, through: :specialties
  has_many :slots
  has_many :cities, through: :slots
  has_many :workshop_slot_teachers
  has_many :workshop_slots, through: :workshop_slot_teachers
  has_many :workshops, through: :workshop_slots
  has_one_attached :photo

  accepts_nested_attributes_for :slots

  enum :status, "Public" => 0, "Privé" => 1
  scope :active, -> {where(status: 0)}

  def name
    "#{first_name} #{last_name}"
  end

  def student_count(season)
    Course.joins(:subscription, :slot).where(subscription: Subscription.active(season), slot: {teacher: self}).group(:slot).count.collect {|id, count|
      slot = Slot.find_by(id: id)
      "#{slot.day_of_week} à #{slot.city.name}: #{count}"
    }.join(", ")
  end

  def students_by_slot
    Course.joins(:subscription, :slot).where(slot: {teacher: self}).group(:slot).count
  end
end
