class Subscription < ApplicationRecord
  belongs_to :student
  has_one :loan
  has_many :courses
  has_many :instrument, through: :courses
  has_many :subbed_pathways
  has_many :pathway_slots, through: :subbed_pathways
  has_many :kid_workshop_slots, through: :subbed_kid_workshops
  has_many :subbed_workshops, dependent: :destroy
  has_many :workshop_slots, through: :subbed_workshops
  has_many :workshops, through: :workshop_slots
  belongs_to :subscription_group
  delegate :season, to: :subscription_group
  delegate :household, to: :subscription_group

  validate :student_unique_subscription, on: :create

  accepts_nested_attributes_for :student, :courses, :subbed_workshops, :workshop_slots, :loan, allow_destroy: true

  STATUSES = {
    INQUIRY: "Demande d’information",
    REGISTERED: "Inscrit",
    CANCELED: "Annulé"
    # ON_HOLD: "Dans le panier"
  }

  enum status: {
    "Demande d’information": 0,
    "Inscrit": 1,
    "Annulé": 2
  }

  scope :active, ->(season) {includes(:subscription_group).where(subscription_group: { season: season })}
  scope :not_on_hold, -> {where.not(subscription_group: SubscriptionGroup.where(status: "Dans le panier"))}
  scope :registered, ->(season) {active(season).where.not(status: [nil, 0])}
  scope :inquired, ->(season) {active(season).where(status: 0)}
  scope :has_optional_workshop, ->(workshop) { where(subbed_workshops.optional.has_workshop(workshop)) }
  scope :has_confirmed_workshop, ->(workshop) { where(subbed_workshops.confirmed.has_workshop(workshop)) }
  scope :has_optional_kid_workshop, ->(workshop) { where(subbed_workshops.optional.has_kid_workshop(workshop)) }
  scope :has_confirmed_kid_workshop, ->(workshop) { where(subbed_workshops.confirme.has_kid_workshop(workshop)) }
  scope :latest, -> {order(created_at: :desc)}

  scope :youth, -> { includes(:student).where(Student.youth) }
  scope :adults, -> { includes(:student).where(Student.adults) }
  scope :undefined_age, -> { includes(:student).where(student: Student.undefined_age) }

  def student_unique_subscription
    if student.subscriptions.active(subscription_group.season).size > 0
      errors.add(:base, "L’élève est déjà inscrit pour cette année.")
    end
  end

  def kid_workshop_list
    workshop_slots.youth.map {|slot|
      slot.workshop.name
  }.join(", ")
  end

  def course_list
    courses.map {|course|
      course.instrument.name
  }.join(", ")
  end

  def workshop_list
    workshop_slots.adults.map {|slot|
      slot.workshop.name
  }.join(", ")
  end

  def pathway_list
    pathway_slots.map {|slot|
      slot.pathway.name
  }.join(", ")
  end

  def address
    student.address.presence || subscription_group&.household&.address
  end

  def phone
    student.phone&.phony_formatted(normalize: :FR) || subscription_group.household.phones
  end

  def email
    student.email.presence || subscription_group.household.emails
  end

  def postcode
    student.postcode.presence || subscription_group&.household&.postcode
  end

  def city
    student.city.presence || subscription_group.household.city
  end

  def optional?
    ["Demande d’information", "Annulé"].include?(status)
  end

  def optional_course?(instrument)
    courses.find_by(instrument: instrument).option == "Optionel"
  end

  def optional_workshop?(workshop)
    subbed_workshops.includes(:workshop_slot).find_by(workshop_slot: {workshop: workshop}).option == "Optionel"
  end

  def optional_kid_workshop?(workshop)
    subbed_workshops.youth.includes(:workshop_slot).find_by(workshop_slot: {workshop: workshop}).option == "Optionel"
  end

  def course_cost
    courses.confirmed.map { |course| course.price }.sum
  end

  def workshop_cost
    subbed_workshops.adults.confirmed.map { |workshop| workshop.price }.sum
  end

  def kid_workshop_cost
    subbed_workshops.youth.confirmed.map { |workshop| workshop.price }.sum
  end

  def all_workshops_cost
    extra_workshops = subbed_workshops.adults.confirmed.size + courses.size
    subbed_workshops.adults.confirmed.map { |workshop| workshop.price }.compact.sort!.reverse.drop(courses.size).sum
  end

  def loan_cost
    loan.presence.cost
  end

  def total_cost
    [kid_workshop_cost, course_cost, all_workshops_cost].compact.sum
  end
end
