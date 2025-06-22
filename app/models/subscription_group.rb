class SubscriptionGroup < ApplicationRecord
  belongs_to :payor
  belongs_to :season
  has_many :subscriptions, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :students, through: :subscriptions
  delegate :plan, to: :season

  accepts_nested_attributes_for :subscriptions, :payments, allow_destroy: true

  STATUSES = {
    INQUIRY: "Demande d’information",
    REGISTERED: "Inscrit",
    CANCELED: "Annulé",
    ON_HOLD: "Dans le panier"
  }

  enum status: {
    "Demande d’information": 0,
    "Inscrit": 1,
    "Annulé": 2,
    "Dans le panier": 3
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
    return status if status != "Inscrit"
      
    state = if total_payment.nil?
      "À régler"
    elsif amount.nil?
      "Montant de l’inscription à renseigner"
    elsif total_payment < amount
      "Règlement partiel"
    elsif total_payment == amount
      "Réglé"
    else
      "Trop perçu"
    end

    "#{status} – #{state}"
  end

  def course_cost
    subscriptions.present? ? subscriptions.map {|subscription| subscription.total_cost}.compact.sum : 0
  end

  def additional_cost
    if majoration_class == "Redon Agglo"
      0
    elsif majoration_class == "Oust à Brocéliande Communauté"
      course_cost * plan.obc_markup / 100
    else
      course_cost * plan.outbounds_markup / 100
    end
  end

  def subscription_cost
    [course_cost, additional_cost].sum
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

  def discount
    if discount_percentage.nil?
      return 0
    end

    subscription_cost * discount_percentage / 100
  end

  def subscription_cost_after_discount
    subscription_cost - discount
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

  def send_subscription_confirmation(user)
    SubscriptionMailer
      .confirm_subscription(user)
      .deliver_later
  end
end
