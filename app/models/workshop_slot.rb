class WorkshopSlot < ApplicationRecord
  include WithTime

  has_many :subbed_workshops
  has_many :subscriptions, through: :subbed_workshops
  has_many :workshop_slot_teachers, dependent: :delete_all
  has_many :teachers, through: :workshop_slot_teachers
  belongs_to :workshop
  belongs_to :city

  scope :active, -> {where(status: 0)}

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

  def name
    "#{workshop.name} – #{teacher_names} à #{city.name}"
  end

  def teachers_and_location
    "#{city.name} (#{teacher_names})"
  end

  def subbed_workshops
    SubbedWorkshop.joins(:subscription, :workshop_slot).where(workshop_slot: self)
  end
end
