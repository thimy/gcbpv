class SubbedKidWorkshop < ApplicationRecord
  belongs_to :kid_workshop_slot
  belongs_to :subscription
  delegate :kid_workshop, to: :kid_workshop_slot
  delegate :student, to: :subscription
  delegate :subscription_group, to: :subscription

  enum :option, "Confirmé" => 0, "Optionel" => 1

  TYPE_PRICES = {
    "Parent-Enfant": "parent_kid_price",
    "Éveil": "early_learning_price",
    "Découverte": "kid_discovery_price"
  }

  scope :registered, -> {joins(:subscription).where(subscription: Subscription.registered)}
  scope :inquired, -> {joins(:subscription).where(subscription: Subscription.inquired)}
  scope :has_workshop, ->(workshop) {includes(:kid_workshop_slot).where(kid_workshop_slot: {kid_workshop: workshop})}
  scope :has_slot, ->(slot) {where(kid_workshop_slot: slot)}
  scope :confirmed, -> { where(option: "Confirmé")}
  scope :optional, -> { where(option: "Optionel")}

  def student_name
    subscription.student.name
  end

  def workshop_name
    kid_workshop_slot.name
  end

  def is_option?
    option == "Optionel" || subscription.subscription_group.status == "Demande d’information"
  end

  def price
    subscription_group.season.plan[TYPE_PRICES[kid_workshop.workshop_type.to_sym]]
  end
end
