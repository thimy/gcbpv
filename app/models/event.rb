class Event < ApplicationRecord
  include WithTime

  def date
    if end_date.present?
      "Du #{format_date(start_date)} au #{format_date(end_date)}"
    else
      format_date(start_date)
    end
  end
end
