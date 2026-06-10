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

  validates :slot, presence: true
  validates :instrument, presence: true
  validates :subscription, presence: true

  PRICES = {
    "Redon Agglo": {
      price_name: "class_price",
      kids_price_name: "kids_class_price",
      double_workshop_price_name: "class_double_workshop_price",
      kids_double_workshop_price_name: "kid_class_double_workshop_price",
    },
    "Oust à Brocéliande Communauté": {
      price_name: "class_price_obc",
      kids_price_name: "kids_class_price_obc",
      double_workshop_price_name: "class_double_workshop_price_obc",
      kids_double_workshop_price_name: "kid_class_double_workshop_price_obc",
      markup_name: "obc_markup"
    },
    "Hors agglo": {
      price_name: "class_price_outbounds",
      kids_price_name: "kids_class_price_outbounds",
      double_workshop_price_name: "class_double_workshop_price_outbounds",
      kids_double_workshop_price_name: "kid_class_double_workshop_price_outbounds",
      markup_name: "outbounds_markup"
    }
  }

  enum :option, "Confirmé" => 0, "Optionel" => 1

  enum :frequency, {
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

  def price(double_workshop: false)
    price_class = PRICES[majoration_class.to_sym]
    if student.birth_year.present? && season.start_year - student.birth_year < 19
      double_workshop ? plan[price_class[:kids_double_workshop_price_name]] : plan[price_class[:kids_price_name]] || plan.kids_class_price + plan.kids_class_price * plan[price_class[:markup_name]] / 100
    else 
      double_workshop ? plan[price_class[:double_workshop_price_name]] : plan[price_class[:price_name]] || plan.class_price + plan.class_price * plan[price_class[:markup_name]] / 100
    end
  end



  def optional?
    option == "Optionel" || subscription.optional?
  end
end
