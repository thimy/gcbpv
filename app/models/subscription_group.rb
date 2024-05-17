class SubscriptionGroup < ApplicationRecord
  belongs_to :payor
  belongs_to :season
  has_many :subscriptions
  has_many :payments
  has_many :students, through: :subscriptions

  accepts_nested_attributes_for :subscriptions, :payments, allow_destroy: true
end
