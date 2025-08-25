class Event < ApplicationRecord
  include WithTime
  include WithAttachment
  include WithEditor
  include Sluggable

  has_one_attached :cover
  has_many :posts
  has_many :attachments, as: :attachable, dependent: :destroy
  belongs_to :bogue, optional: true
  belongs_to :parent_event, class_name: "Event", optional: true

  slugify :name

  scope :ordered, -> { order(start_date: :desc, start_time: :desc)}
  scope :upcoming, -> {where(end_date: Date.today...).or(has_no_end_date.where(start_date: Date.today...))}
  scope :has_no_end_date, -> {where(end_date: nil)}
  scope :start_passed, -> {where(start_date: ...Date.today)}
  scope :end_passed, -> {where(end_date: ...Date.today)}
  scope :passed, -> {has_no_end_date.start_passed.or(end_passed)}
  scope :active, -> {where(status: 0)}
  scope :emt, -> {where(is_emt: true)}

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

  def upcoming
    if end_date.nil?
      start_date >= Date.today
    else
      end_date >= Date.today
    end
  end

  def passed
    if end_date.nil?
      start_date < Date.today
    else
      end_date < Date.today
    end
  end

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
