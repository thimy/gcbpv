class Course < ApplicationRecord
  belongs_to :instrument
  belongs_to :slot
  has_many :teachers, through: :slots
  belongs_to :subscription
  delegate :student, to: :subscription
  delegate :subscription_group, to: :subscription

  enum :option, "Confirmé" => 0, "Optionel" => 1

  scope :ordered, -> { order(start_time: :asc) }

  def name
    "#{instrument.name} - #{slot.name}"
  end

  def price
    subscription_group.season.plan.class_price
  end
end
