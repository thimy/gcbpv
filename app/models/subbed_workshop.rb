class SubbedWorkshop < ApplicationRecord
  belongs_to :workshop_slot
  belongs_to :subscription
  delegate :workshop, to: :workshop_slot
  delegate :student, to: :subscription
  delegate :subscription_group, to: :subscription

  enum :option, "Confirmé" => 0, "Optionel" => 1

  scope :registered, -> {joins(:subscription).where(subscription: Subscription.registered)}
  scope :inquired, -> {joins(:subscription).where(subscription: Subscription.inquired)}
  scope :has_workshop, ->(workshop) {includes(:workshop_slot).where(workshop_slot: {workshop: workshop})}
  scope :has_slot, ->(slot) {where(workshop_slot: slot)}
  scope :confirmed, -> { where(option: "Confirmé")}
  scope :optional, -> { where(option: "Optionel")}
  scope :ordered, -> { includes(:workshop_slot).order("workshop_slots.day_of_week", "workshop_slots.slot_time") }

  def student_name
    subscription.student.name
  end

  def workshop_name
    workshop_slot.name
  end

  def is_option?
    option == "Optionel" || subscription.subscription_group.status == 0
  end

  def price
    if workshop.workshop_type == "Spécial"
      subscription_group.season.plan.special_workshop_price
    else
      subscription_group.season.plan.workshop_price
    end
  end
end
