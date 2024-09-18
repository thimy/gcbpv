class Course < ApplicationRecord
  belongs_to :instrument
  belongs_to :slot
  has_many :teachers, through: :slots
  belongs_to :subscription
  delegate :student, to: :subscription
  delegate :subscription_group, to: :subscription

  enum :option, "Confirmé" => 0, "Optionel" => 1

  scope :ordered, -> { includes(:slot).order("slots.day_of_week", :start_time) }

  def name
    "#{instrument.name} - #{slot.name}"
  end

  def price
    subscription_group.season.plan.class_price
  end
end
