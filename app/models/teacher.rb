class Teacher < ApplicationRecord
  has_many :specialties, dependent: :delete_all
  has_many :instruments, through: :specialties
  has_many :slots
  has_many :cities, through: :slots
  has_many :workshop_slot_teachers
  has_many :workshop_slots, through: :workshop_slot_teachers
  has_one_attached :photo

  accepts_nested_attributes_for :slots

  enum :status, "Public" => 0, "Privé" => 1
  scope :active, -> {where(status: 0)}

  def name
    "#{first_name} #{last_name}"
  end

  def student_count
    Course.joins(:subscription, :slot).where(slot: {teacher: self}).group(:instrument_id).count.collect {|id, count|
      "#{Instrument.find_by(id: id).name}: #{count}"
    }.join(", ")
  end
end
