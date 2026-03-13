class Teacher < ApplicationRecord
  include WithPerson
  phony_normalize :phone, default_country_code: "FR"

  has_one :user
  has_many :specialties, dependent: :delete_all
  has_many :instruments, through: :specialties
  has_many :slots
  has_many :courses, through: :slots
  has_many :cities, through: :slots
  has_many :workshop_slot_teachers
  has_many :workshop_slots, through: :workshop_slot_teachers
  has_many :workshops, through: :workshop_slots
  has_one_attached :photo
  has_many :teacher_seasons
  has_many :seasons, through: :teacher_seasons

  accepts_nested_attributes_for :slots

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :email, presence: true

  enum :status, "Public" => 0, "Privé" => 1
  scope :visible, -> {where(status: 0)}
  scope :active, -> (season) { includes(:teacher_seasons).where(teacher_seasons: {season: season})}
  scope :with_instrument, -> (instrument) { includes(:specialties).where(specialties: {instrument: instrument}) }

  def name
    [first_name, last_name].compact.join(" ")
  end

  def student_count(season)
    Course.joins(:subscription, :slot).where(subscription: Subscription.active(season), slot: {teacher: self}).group(:slot).count.collect {|id, count|
      slot = Slot.find_by(id: id)
      "#{slot.day_of_week} à #{slot.city.name}: #{count}"
    }.join(", ")
  end

  def has_students?(season)
    Course.joins(:subscription, :slot).where(subscription: Subscription.active(season), slot: {teacher: self}).size.to_i != 0
  end

  def students_by_slot
    Course.joins(:subscription, :slot).where(slot: {teacher: self}).group(:slot).count
  end

  def has_workshops?(season)
    subscriptions = 0
    workshop_slots.each {|slot|
      subscriptions += slot.subscriptions.active(season).size.to_i
    }
    
    subscriptions != 0
  end
end
