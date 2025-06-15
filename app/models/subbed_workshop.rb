class SubbedWorkshop < ApplicationRecord
  include WithSubbedWorkshop

  belongs_to :workshop_slot
  belongs_to :subscription
  delegate :workshop, to: :workshop_slot
  delegate :student, to: :subscription
  delegate :subscription_group, to: :subscription

  enum :option, "Confirmé" => 0, "Optionel" => 1

  scope :registered, ->(season) {joins(:subscription).where(subscription: Subscription.registered(season))}
  scope :inquired, ->(season) {joins(:subscription).where(subscription: Subscription.inquired(season))}
  scope :confirmed, -> { where(option: "Confirmé")}
  scope :optional, -> { where(option: "Optionel")}

  scope :has_workshop, ->(workshop) {includes(:workshop_slot).where(workshop_slot: {workshop: workshop})}
  scope :has_slot, ->(slot) {where(workshop_slot: slot)}
  scope :ordered, -> { includes(:workshop_slot).order("workshop_slots.day_of_week", "workshop_slots.slot_time") }

  def workshop_name
    workshop_slot.name
  end

  def price
    if workshop.workshop_type == "Spécial"
      subscription_group.season.plan.special_workshop_price
    elsif workshop.workshop_type == "Autonome"
      subscription_group.season.plan.standalone_workshop_price
    else
      subscription_group.season.plan.workshop_price
    end
  end
end
