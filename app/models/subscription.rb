class Subscription < ApplicationRecord
  belongs_to :student
  has_many :courses
  has_many :instrument, through: :courses
  has_many :subbed_pathways
  has_many :pathway_slots, through: :subbed_pathways
  has_many :subbed_kid_workshops, dependent: :destroy
  has_many :kid_workshop_slots, through: :subbed_kid_workshops
  has_many :subbed_workshops, dependent: :destroy
  has_many :workshop_slots, through: :subbed_workshops
  has_many :workshops, through: :workshop_slots
  belongs_to :subscription_group

  accepts_nested_attributes_for :student, :courses, :subbed_workshops, :subbed_kid_workshops, :workshop_slots, allow_destroy: true

  enum status: {
    "Demande d’information": 0,
    "Inscrit – à régler": 1,
    "Inscrit – réglé": 2,
    "Inscrit – À rembourser": 3,
    "Annulé": 4
  }

  scope :active, -> {includes(:subscription_group).where(subscription_group: { season: Config.first.season })}
  scope :registered, ->{active.where(subscription_group: { status: [1, 2, 3] })}
  scope :inquired, ->{active.where.not(id: registered)}
  scope :has_optional_workshop, ->(workshop) { where(subbed_workshops.optional.has_workshop(workshop)) }
  scope :has_confirmed_workshop, ->(workshop) { where(subbed_workshops.confirme.has_workshop(workshop)) }
  scope :has_optional_kid_workshop, ->(workshop) { where(subbed_workshops.optional.has_kid_workshop(workshop)) }
  scope :has_confirmed_kid_workshop, ->(workshop) { where(subbed_workshops.confirme.has_kid_workshop(workshop)) }

  def kid_workshop_list
    kid_workshop_slots.map {|slot|
      slot.kid_workshop.name
  }.join(", ")
  end

  def course_list
    courses.map {|course|
      course.instrument.name
  }.join(", ")
  end

  def workshop_list
    workshop_slots.map {|slot|
      slot.workshop.name
  }.join(", ")
  end

  def pathway_list
    pathway_slots.map {|slot|
      slot.pathway.name
  }.join(", ")
  end

  def phone
    student.phone.presence || subscription_group.payor.phone
  end

  def email
    student.email.presence || subscription_group.payor.email
  end

  def city
    student.city.presence || subscription_group.payor.city
  end

  def optional?
    ["Demande d’information", "Annulé"].include?(subscription_group.status) if subscription_group.status.present?
  end

  def optional_course?(instrument)
    courses.find_by(instrument: instrument).option == "Optionel"
  end

  def optional_workshop?(workshop)
    subbed_workshops.includes(:workshop_slot).find_by(workshop_slot: {workshop: workshop}).option == "Optionel"
  end

  def optional_kid_workshop?(kid_workshop)
    subbed_kid_workshops.includes(:kid_workshop_slot).find_by(kid_workshop_slot: {kid_workshop: kid_workshop}).option == "Optionel"
  end
end
