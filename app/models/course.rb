class Course < ApplicationRecord
  belongs_to :instrument
  belongs_to :slot
  has_many :teachers, through: :slots
  belongs_to :subscription
  delegate :student, to: :subscription
  delegate :subscription_group, to: :subscription
  delegate :season, to: :subscription_group

  enum :option, "Confirmé" => 0, "Optionel" => 1

  scope :ordered, -> { includes(:slot).order("slots.day_of_week", :start_time) }
  scope :confirmed, -> { where(option: "Confirmé") }
  scope :optional, -> { where(option: "Optionel") }
  scope :active, ->(season) { joins(:subscription).where(subscription: Subscription.joins(:subscription_group).where(subscription_group: SubscriptionGroup.active(season))) }

  def name
    "#{instrument.name} - #{slot.name}"
  end

  def price
    if student.birth_year.present? && subscription_group.season.start_year - student.birth_year <= 18
      subscription_group.season.plan.kids_class_price
    else 
      subscription_group.season.plan.class_price
    end
  end

  def optional?
    option == "Optionel" || subscription.optional?
  end
end
