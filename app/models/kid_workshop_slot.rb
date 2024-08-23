class KidWorkshopSlot < ApplicationRecord
  has_many :subbed_kid_workshops
  has_many :subscriptions, through: :subbed_kid_workshops
  has_many :kid_workshop_slot_teachers
  has_many :teachers, through: :kid_workshop_slot_teachers
  belongs_to :kid_workshop
  belongs_to :city

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

  def datetime
    sentence = []
    sentence << "le #{day_of_week}" if day_of_week.present?
    sentence << frequency if frequency.present?
    sentence << time_period if time_period.present?

    sentence.join(" ").downcase.capitalize
  end

  def teacher_names
    teachers.map {|teacher| teacher.name }.join("/")
  end

  def name
    "#{city.name} – #{day_of_week} – #{slot_time || "Horaire à définir"}"
  end

  def subscriptions
    Subscription.joins(:kid_workshop_slot).where(kid_workshop_slot: self)
  end

  def subbed_workshops
    SubbedKidWorkshop.joins(:subscription, :kid_workshop_slot).where(kid_workshop_slot: self)
  end

  def subscription_count
    subbed_workshops.size
  end
end
