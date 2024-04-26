module WithTime
  extend ActiveSupport::Concern

  DAYS_ORDERED = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]

  FREQUENCIES = [
    "Hebdomadaire",
    "Toutes les deux semaines",
    "Semaines paires",
    "Semaines impaires",
    "Tous les mois",
    "Six séances dans l'année",
    "A définir"
  ]

  def time(time)
    time.strftime("%kh%M")
  end
end
