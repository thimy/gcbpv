class Course < ApplicationRecord
  include WithTime
  belongs_to :instrument
  belongs_to :slot
  has_many :teachers, through: :slots
  belongs_to :subscription
  delegate :student, to: :subscription
  delegate :subscription_group, to: :subscription
  delegate :majoration_class, to: :subscription_group
  delegate :season, to: :subscription_group
  delegate :plan, to: :season

  PRICES = {
    "Redon Agglo": {
      price_name: "class_price",
      kids_price_name: "kids_class_price",
    },
    "Oust à Brocéliande Communauté": {
      price_name: "class_price_obc",
      kids_price_name: "kids_class_price_obc",
      markup_name: "obc_markup"
    },
    "Hors agglo": {
      price_name: "class_price_outbounds",
      kids_price_name: "kids_class_price_outbounds",
      markup_name: "outbounds_markup"
    }
  }

  enum :option, "Confirmé" => 0, "Optionel" => 1

  enum frequency: {
    "Toutes les semaines": 0,
    "Toutes les deux semaines": 1,
    "Les semaines paires": 2,
    "Les semaines impaires": 3,
    "Tous les mois": 4
  }

  scope :ordered, -> { includes(:slot).order("slots.day_of_week", :start_time) }
  scope :confirmed, -> { where(option: "Confirmé") }
  scope :optional, -> { where(option: "Optionel") }
  scope :active, ->(season) { joins(:subscription).where(subscription: Subscription.joins(:subscription_group).where(subscription_group: SubscriptionGroup.active(season))) }

  def name
    "#{instrument.name} - #{slot.name}"
  end

  def price
    price_class = PRICES[majoration_class.to_sym]
    if student.birth_year.present? && season.start_year - student.birth_year < 19
      p = plan[price_class[:kids_price_name]] || plan.kids_class_price + plan.kids_class_price * plan[price_class[:markup_name]] / 100
    else 
      p = plan[price_class[:price_name]] || plan.class_price + plan.class_price * plan[price_class[:markup_name]] / 100
    end
  end

  def optional?
    option == "Optionel" || subscription.optional?
  end
end
