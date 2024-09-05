class SubscriptionGroup < ApplicationRecord
  belongs_to :payor
  belongs_to :season
  has_many :subscriptions, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :students, through: :subscriptions

  accepts_nested_attributes_for :subscriptions, :payments, allow_destroy: true

  enum status: {
    "Demande d’information": 0,
    "Inscrit": 1,
    "Annulé": 2
  }

  enum majoration_class: {
    "Redon Agglo": 0,
    "OBC communauté": 1,
    "Hors agglo": 2
  }

  scope :unconfirmed, -> { where(status: 0) }
  scope :confirmed, -> { where(status: [nil, 1]) }

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
    elsif total_payment < amount
      "Règlement partiel"
    elsif total_payment == amount
      "Réglé"
    else
      "Trop perçu"
    end

    "#{status} – #{state}"
  end
end
