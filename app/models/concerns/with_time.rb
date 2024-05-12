module WithTime
  extend ActiveSupport::Concern

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
      "Jour à définir"
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
      "Horaire à définir"
    end
  end
end
