class WorkshopSlot < ApplicationRecord
  include WithTime

  has_many :subbed_workshops
  has_many :subscriptions, through: :subbed_workshops
  has_many :students, through: :subscriptions
  has_many :workshop_slot_teachers, dependent: :delete_all
  has_many :teachers, through: :workshop_slot_teachers
  belongs_to :workshop
  belongs_to :city
  delegate :is_youth, to: :workshop

  scope :active, -> {where(status: 0)}
  scope :visible, -> {where(status: 0, is_custom: [false, nil])}
  scope :custom, -> {where(is_custom: true)}
  scope :ordered, -> {order(day_of_week: :asc)}
  scope :youth, -> {includes(:workshop).where(workshop: {is_youth: true})}
  scope :adults, -> {includes(:workshop).where.not(workshop: Workshop.youth)}

  enum :status, "Public" => 0, "Privé" => 1

  enum day_of_week: {
    "À définir": 0,
    "Lundi": 1,
    "Mardi": 2,
    "Mercredi": 3,
    "Jeudi": 4,
    "Vendredi": 5,
    "Samedi": 6,
    "Dimanche": 7,
  }

  enum frequency: {
    "Toutes les semaines": 0,
    "Toutes les deux semaines": 1,
    "Les semaines paires": 2,
    "Les semaines impaires": 3,
    "Tous les mois": 4,
    "Six séances dans l'année": 5,
    "A définir": 6
  }

  def teacher_names
    teachers.map {|teacher| teacher.name }.join("/")
  end

  def full_name
    [workshop.name, [teacher_names, city.name].join(" à ")].join(" - ")
  end

  def name
    "#{city.name} – #{day_of_week} – #{slot_time || "Horaire à définir"}"
  end

  def teachers_and_location
    "#{city.name} (#{teacher_names})"
  end

  def subbed_workshops
    SubbedWorkshop.joins(:subscription, :workshop_slot).where(workshop_slot: self)
  end

  def subscription_count
    subbed_workshops.size
  end
end
