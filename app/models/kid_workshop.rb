class KidWorkshop < Workshop
  has_many :workshop_slots
  has_many :subbed_workshops, through: :workshop_slots
  has_many :subscriptions, through: :subbed_workshops
  has_many :cities, through: :workshop_slots

  accepts_nested_attributes_for :workshop_slots

  enum :status, "Public" => 0, "Privé" => 1

  scope :visible, -> { where(status: 0) }
  scope :active, ->(season) { includes(:workshop_seasons).where(workshop_seasons: {season: season})}
  
  validates :name, presence: true

  def self.all
    Workshop.where(is_youth: true)
  end

  def student_count
    students_by_slot.join(", ")
  end

  def students_by_slot
    SubbedWorkshop.joins(:subscription, :workshop_slot).where(workshop_slot: {workshop: self}).group(:workshop_slot_id).count.collect {|id, count|
      slot = KidWorkshopSlot.find_by(id: id)
      "#{slot.city.name} - #{slot.day_of_week} avec #{slot.teacher_names}: #{count}"
    }
  end

  def subscriptions
    SubbedWorkshop.joins(:subscription, :workshop_slot).where(workshop_slot: {workshop: self})
  end
end
