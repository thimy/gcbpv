class Slot < ApplicationRecord
  include WithTime

  belongs_to :teacher
  belongs_to :city

  enum day_of_week: {
    "Jour à définir": 0,
    "Lundi": 1,
    "Mardi": 2,
    "Mercredi": 3,
    "Jeudi": 4,
    "Vendredi": 5,
    "Samedi": 6,
    "Dimanche": 7,
  }

  enum frequency: {
    "Fréquence à définir": 0,
    "Hebdomadaire": 1,
    "Toutes les deux semaines": 2,
    "Semaines paires": 3,
    "Semaines impaires": 4,
    "Tous les mois": 5,
    "Six séances dans l'année": 6
  }

  def name
    "#{teacher.name} à #{city.name} #{datetime}"
  end

  def name_without_city
    "#{teacher.name} #{datetime}"
  end

  def datetime
    if day_of_week.present?
      "le #{day_of_week} - #{time_period}".downcase
    else
      "jour et horaires à définir"
    end
  end
end
