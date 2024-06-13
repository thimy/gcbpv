class WorkshopSlot < ApplicationRecord
  include WithTime

  has_many :workshop_slot_teachers
  has_many :teachers, through: :workshop_slot_teachers
  belongs_to :workshop
  belongs_to :city

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
end
