class Event < ApplicationRecord
  include WithTime
  has_one_attached :image
  has_many :posts

  scope :upcoming, -> {where(start_date: Date.today...)}
  scope :passed, -> {where(start_date: ...Date.today)}

  scope :past_week, -> { where(created_at: Time.zone.now.at_beginning_of_week...Time.zone.now.at_end_of_week) }

  enum :status, "Public" => 0, "Privé" => 1
end
