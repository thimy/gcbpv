class SubscriptionGroup < ApplicationRecord
  belongs_to :household
  belongs_to :season
  has_many :subscriptions, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :students, through: :subscriptions
  delegate :plan, to: :season

  accepts_nested_attributes_for :subscriptions, :payments, allow_destroy: true

  STATUSES = {
    INQUIRY: "Demande d’information",
    REGISTERED: "Inscrit",
    CANCELED: "Annulé"
    # ON_HOLD: "Dans le panier"
  }

  enum status: {
    "Demande d’information": 0,
    "Inscrit": 1,
    "Annulé": 2,
    # "Dans le panier": 3
  }

  enum majoration_class: {
    "Redon Agglo": 0,
    "Oust à Brocéliande Communauté": 1,
    "Hors agglo": 2
  }

  scope :unconfirmed, -> { where(status: 0) }
  scope :confirmed, -> { where(status: [nil, 1]) }
  scope :not_on_hold, -> {where(status: [nil, 0, 1, 2])}
  scope :active, ->(season) { where(season: season)}

  def student_list
    subscriptions.map {|subscription|
      subscription.student.name
  }.join(", ")
  end

  def total_payment
    payments.pluck(:amount).reduce(:+)
  end

  def payment_state
    return STATUSES[status.to_sym] if status != "Inscrit"
      
    if total_payment.nil?
      "À régler"
    elsif total_payment < total_cost
      "Partiel"
    elsif total_payment == total_cost
      "Réglé"
    else
      "Trop perçu"
    end
  end

  def subscription_cost
    subscriptions.present? ? subscriptions.map {|subscription| subscription.total_cost}.compact.sum : 0
  end

  def discount_percentage
    if subscription_cost < plan.first_step
      return
    end

    if subscription_cost < plan.second_step
      plan.first_step_discount
    elsif subscription_cost < plan.third_step
      plan.second_step_discount
    else
      plan.third_step_discount
    end
  end

  def subscriptions_discount
    if discount_percentage.nil?
      return 0
    end

    subscription_cost * discount_percentage / 100
  end

  def subscription_cost_after_discount
    subscription_cost - subscriptions_discount - (discount || 0)
  end

  def total_cost
    [subscription_cost_after_discount, plan.membership_price, donation].compact.sum
  end

  def total_paid
    payments.pluck(:amount).sum
  end

  def total_remaining
    total_cost - total_paid
  end

  def redon_agglo?
    majoration_class == "Redon Agglo"
  end

  def obc?
    majoration_class == "Oust à Brocéliande Communauté"
  end

  def agglo_markup
    if redon_agglo?
      0
    elsif obc?
      Config.first.season.plan.obc_markup
    else
      Config.first.season.plan.outbounds_markup
    end
  end

  def send_subscription_confirmation(user)
    SubscriptionMailer
      .confirm_subscription(user)
      .deliver_later
  end
end
