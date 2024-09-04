class Event < ApplicationRecord
  include WithTime
  include WithAttachment
  include WithEditor

  has_one_attached :image
  has_many :posts
  has_many :attachments, as: :attachable, dependent: :destroy

  scope :ordered, -> { order(start_date: :asc) }
  scope :upcoming, -> {where(start_date: Date.today...)}
  scope :passed, -> {where(start_date: ...Date.today)}

  scope :past_week, -> { where(created_at: Time.zone.now.at_beginning_of_week...Time.zone.now.at_end_of_week) }

  enum :status, "Public" => 0, "Privé" => 1

  def full_location
    full_location = []
    full_location << location if location.present?
    full_location << city.upcase if city.present?
    full_location.join(" – ")
  end
end
