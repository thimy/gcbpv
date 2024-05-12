class Workshop < ApplicationRecord
  include WithTime

  belongs_to :city, optional: true
  has_and_belongs_to_many :teachers
  has_many :subscriptions, through: :subbed_workshops

  validates :name, presence: true

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

  def datetime
    sentence = []
    sentence << "le #{day_of_week}" if day_of_week.present?
    sentence << frequency if frequency.present?
    sentence << time_period if time_period.present?

    sentence.join(" ").downcase.capitalize
  end
end
