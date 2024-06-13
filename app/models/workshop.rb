class Workshop < ApplicationRecord
  include WithTime

  has_and_belongs_to_many :teachers
  has_many :subscriptions, through: :subbed_workshops
  has_many :workshop_slots
  has_many :cities, through: :workshop_slots

  accepts_nested_attributes_for :workshop_slots

  validates :name, presence: true

  scope :active, -> {where(archived: false)}

  def datetime
    sentence = []
    sentence << "le #{day_of_week}" if day_of_week.present?
    sentence << frequency if frequency.present?
    sentence << time_period if time_period.present?

    sentence.join(" ").downcase.capitalize
  end
end
