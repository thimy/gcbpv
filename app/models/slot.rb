class Slot < ApplicationRecord
  include WithTime

  belongs_to :teacher
  belongs_to :city
  has_many :subscriptions

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
    "Six séances dans l'année": 6,
    "5x4 séances par répertoire": 7
  }

  def name
    "#{teacher.name} à #{city.name} #{datetime}"
  end

  def name_without_city
    "#{teacher.name} #{datetime}"
  end

  def datetime
    if day_of_week.present? && slot_time.present?
      "le #{day_of_week} - #{slot_time}".downcase
    elsif day_of_week.present?
      "le #{day_of_week} - horaires à définir"
    elsif slot_time.present?
      "jour à définir - #{slot_time}".downcase
    else
      "jour et horaires à définir"
    end
  end

  def courses
    Course.joins(:subscription, :slot).where(slot: self)
  end

  def student_count
    students.count
  end
end
