class Workshop < ApplicationRecord
  include WithTime

  has_and_belongs_to_many :teachers
  has_many :workshop_slots
  has_many :subbed_workshops, through: :workshop_slots
  has_many :subscriptions, through: :subbed_workshops
  has_many :students, through: :subscriptions
  has_many :cities, through: :workshop_slots
  belongs_to :price_category
  has_many :plan_price_categories, through: :price_category
  has_many :workshop_seasons
  has_many :seasons, through: :workshop_seasons

  accepts_nested_attributes_for :workshop_slots, :plan_price_categories

  validates :name, presence: true

  enum :status, "Public" => 0, "Privé" => 1

  scope :active, ->(season) { includes(:workshop_seasons).where(workshop_seasons: {season: season})}
  scope :visible, -> {where(status: 0)}
  scope :youth, ->{where(is_youth: true)}
  scope :adults, ->{where(is_youth: nil)}

  scope :registered, ->(season) { where(workshop_slots: WorkshopSlot.where(subbed_workshops: SubbedWorkshop.where(subscription: Subscription.registered(season)))) }
  scope :subscribed_by_status, ->(status) { where(workshop_slots: WorkshopSlot.where(subbed_workshops: SubbedWorkshop.where(option: status))) }
  scope :confirmed, -> { subscribed_by_status("Confirmé") }
  scope :optional, -> { subscribed_by_status("Optionel") }

  def self.get_count(season, optional: true)
    options = SubbedWorkshop.adults.registered(season).optional.size
    confirmed_subs = SubbedWorkshop.adults.registered(season).confirmed.size
    options == 0 ? confirmed_subs : "#{confirmed_subs} (+#{options})"
  end

  def self.get_workshop_count(season, workshop_id, optional: true)
    options = SubbedWorkshop.where(workshop_slot: WorkshopSlot.where(workshop: Workshop.find(workshop_id))).registered(season).optional.size
    confirmed_subs = SubbedWorkshop.where(workshop_slot: WorkshopSlot.where(workshop: Workshop.find(workshop_id))).registered(season).confirmed.size
    options == 0 ? confirmed_subs : "#{confirmed_subs} (+#{options})"
  end

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
