class Slot < ApplicationRecord
  include WithTime

  belongs_to :teacher
  belongs_to :city

  enum day_of_week: {
    "Lundi": 0,
    "Mardi": 1,
    "Mercredi": 2,
    "Jeudi": 3,
    "Vendredi": 4,
    "Samedi": 5,
    "Dimanche": 6,
    "À définir": 7,
  }

  enum frequency: {
    "Hebdomadaire": 0,
    "Toutes les deux semaines": 1,
    "Semaines paires": 2,
    "Semaines impaires": 3,
    "Tous les mois": 4,
    "Six séances dans l'année": 5,
    "A définir": 6
  }
end
