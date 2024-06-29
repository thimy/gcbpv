class Subscription < ApplicationRecord
  belongs_to :student
  has_many :courses
  has_many :subbed_pathways
  has_many :pathway_slots, through: :subbed_pathways
  belongs_to :kid_workshop_slot, optional: true
  has_many :subbed_workshops
  has_many :workshop_slots, through: :subbed_workshops
  belongs_to :subscription_group

  accepts_nested_attributes_for :student, :courses, :subbed_workshops, :workshop_slots, allow_destroy: true

  enum status: {
    "Demande d’information": 0,
    "Inscrit – à régler": 1,
    "Inscrit – réglé": 2,
    "À rembourser": 3
  }

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
    student.try(:phone) || subscription_group.payor.phone
  end

  def email
    student.try(:email) || subscription_group.payor.email
  end

  def city
    student.try(:city) || subscription_group.payor.city
  end
end
