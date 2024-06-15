class PathwaySlot < ApplicationRecord
  belongs_to :pathway
  belongs_to :city
  has_many :pathway_slot_teachers
  has_many :teachers, through: :pathway_slot_teachers

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
end
