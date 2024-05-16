class SubscriptionGroup < ApplicationRecord
  belongs_to :payor
  belongs_to :season
  has_many :subscriptions
  has_many :payments

  accepts_nested_attributes_for :subscriptions, :payments
end
