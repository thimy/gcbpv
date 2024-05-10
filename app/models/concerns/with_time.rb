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

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end

  def format_datetime(datetime)
    datetime.strftime("%d/%m/%Y à %H:%M")
  end

  def date_period
    if start_date.present?
      if end_date.present? && format_date(end_date) != format_date(start_date)
        "Du #{format_date(start_date)} au #{format_date(end_date)}"
      else
        "Le #{format_date(start_date)}"
      end
    else
      "À définir"
    end
  end

  def time_period
    if start_time.present?
      if end_time.present?
        "De #{start_time} à #{end_time}"
      else
        "À partir de #{start_time}"
      end
    else
      "À définir"
    end
  end
end
