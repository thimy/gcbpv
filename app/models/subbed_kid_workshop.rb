class SubbedKidWorkshop < ApplicationRecord
  include WithSubbedWorkshop

  belongs_to :kid_workshop_slot
  belongs_to :subscription
  delegate :kid_workshop, to: :kid_workshop_slot
  delegate :student, to: :subscription
  delegate :subscription_group, to: :subscription

  enum :option, "Confirmé" => 0, "Optionel" => 1

  TYPE_PRICES = {
    "Parcours famille": "family_pathway_price",
    "Éveil": "early_learning_price",
    "Découverte": "kid_discovery_price"
  }

  scope :registered, ->(season) {joins(:subscription).where(subscription: Subscription.registered(season))}
  scope :inquired, ->(season) {joins(:subscription).where(subscription: Subscription.inquired(season))}
  scope :confirmed, -> { where(option: "Confirmé")}
  scope :optional, -> { where(option: "Optionel")}

  scope :has_workshop, ->(workshop) {includes(:kid_workshop_slot).where(kid_workshop_slot: {kid_workshop: workshop})}
  scope :has_slot, ->(slot) {where(kid_workshop_slot: slot)}
  scope :ordered, -> { includes(:kid_workshop_slot).order("kid_workshop_slots.day_of_week", "kid_workshop_slots.slot_time") }

  def workshop_name
    kid_workshop_slot.name
  end

  def price
    subscription_group.season.plan[TYPE_PRICES[kid_workshop.workshop_type.to_sym]]
  end

  def optional?
    option == "Optionel" || subscription.optional?
  end
end
