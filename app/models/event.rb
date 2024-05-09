class Event < ApplicationRecord
  include WithTime
  has_one_attached :image
  has_many :posts

  scope :upcoming, -> {where(end_date: Date.today...)}
  scope :passed, -> {where(end_date: ...Date.today)}

  scope :past_week, -> { where(created_at: Time.zone.now.at_beginning_of_week...Time.zone.now.at_end_of_week) }

  def date
    if end_date.present?
      "Du #{format_date(start_date)} au #{format_date(end_date)}"
    else
      format_date(start_date)
    end
  end
end
