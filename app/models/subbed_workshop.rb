class SubbedWorkshop < ApplicationRecord
  include WithSubbedWorkshop

  belongs_to :workshop_slot
  delegate :workshop, to: :workshop_slot
  belongs_to :subscription
  delegate :student, to: :subscription
  delegate :subscription_group, to: :subscription
  delegate :season, to: :subscription_group
  delegate :majoration_class, to: :subscription_group
  delegate :plan, to: :season

  validates :subscription, presence: true
  validates :workshop_slot, presence: true

  PRICES = {
    "Redon Agglo": {
      price_name: "workshop_price",
      category_price_name: "price",
    },
    "Oust à Brocéliande Communauté": {
      price_name: "workshop_price_obc",
      category_price_name: "obc_price",
      markup_name: "obc_markup"
    },
    "Hors agglo": {
      price_name: "workshop_price_outbounds",
      category_price_name: "outbounds_price",
      markup_name: "outbounds_markup"
    }
  }

  enum :option, "Confirmé" => 0, "Optionel" => 1

  scope :registered, ->(season) {joins(:subscription).where(subscription: Subscription.registered(season))}
  scope :inquired, ->(season) {joins(:subscription).where(subscription: Subscription.inquired(season))}
  scope :confirmed, -> { where(option: "Confirmé")}
  scope :optional, -> { where(option: "Optionel")}

  scope :has_workshop, ->(workshop) {includes(:workshop_slot).where(workshop_slot: {workshop: workshop})}
  scope :has_slot, ->(slot) {where(workshop_slot: slot)}
  scope :ordered, -> { includes(:workshop_slot).order("workshop_slots.day_of_week", "workshop_slots.slot_time") }
  scope :youth, -> { includes(:workshop_slot).where(workshop_slot: WorkshopSlot.youth) }
  scope :adults, -> { includes(:workshop_slot).where(workshop_slot: WorkshopSlot.adults) }

  def workshop_name
    workshop_slot.name
  end

  def price
    get_price
  end

  def optional?
    option == "Optionel" || subscription.optional?
  end

  private

  def get_price
    price_class = PRICES[majoration_class.to_sym]
    if workshop.price_category.present?
      price_category = plan.plan_price_categories.find_by(price_category: workshop.price_category)
      p = price_category[price_class[:category_price_name]] || price_category.price + price_category.price * plan[price_class[:markup_name]] / 100
    else
      p = plan[price_class[:price_name]] || plan.workshop_price + plan.workshop_price * plan[price_class[:markup_name]] / 100
    end
  end
end
