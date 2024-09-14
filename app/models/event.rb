class Event < ApplicationRecord
  include WithTime
  include WithAttachment
  include WithEditor

  has_one_attached :cover
  has_many :posts
  has_many :attachments, as: :attachable, dependent: :destroy
  belongs_to :bogue, optional: true
  belongs_to :parent_event, class_name: "Event", optional: true

  scope :ordered, -> { order(start_date: :desc) }
  scope :upcoming, -> {where(start_date: Date.today...)}
  scope :passed, -> {where(start_date: ...Date.today)}
  scope :active, -> {where(status: 0)}

  scope :past_week, -> { where(created_at: Time.zone.now.at_beginning_of_week...Time.zone.now.at_end_of_week) }

  enum :status, "Public" => 0, "Privé" => 1
  enum :event_type, {
    "Divers" => 0,
    "Fest-noz / Bal" => 1,
    "Concert" => 2,
    "Concours" => 3,
    "Stage" => 4,
    "Balade" => 5,
    "Scène ouverte / Jam / Session" => 6,
    "Enfance / Jeunes" => 7
  }

  def full_location
    full_location = []
    full_location << location if location.present?
    full_location << city.upcase if city.present?
    full_location.join(" – ")
  end

  def events
    Event.where(parent_event_id: self.id)
  end
end
