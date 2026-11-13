# == Schema Information
#
# Table name: seasons
#
#  id         :bigint           not null, primary key
#  start_year :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plan_id    :bigint           not null
#
# Indexes
#
#  index_seasons_on_plan_id  (plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#
class Season < ApplicationRecord
  belongs_to :plan
  has_many :subscription_groups
  has_many :subscriptions, through: :subscription_groups
  has_many :active_subscriptions, -> { includes(subbed_workshops: :workshop_slot).not_on_hold }, class_name: "Subscription", through: :subscription_groups
  has_many :registered_subscriptions, -> { includes(subbed_workshops: :workshop_slot).not_on_hold.where.not(status: [nil, 0]) }, class_name: "Subscription", through: :subscription_groups
  has_many :subbed_workshops, through: :active_subscriptions
  has_many :registered_subbed_workshops, class_name: 'SubbedWorkshop', through: :active_subscriptions
  has_many :subbed_kid_workshops, through: :active_subscriptions
  validates :start_year, presence: true

  default_scope {order(start_year: :desc)}

  def name
    "#{start_year}-#{start_year+1}"
  end

  def unconfirmed_subscription_groups
    @unconfirmed_subscription_groups ||= SubscriptionGroup.where(season: self).unconfirmed
  end

  def unconfirmed_subscription_groups_size
    unconfirmed_subscription_groups.size
  end

  def confirmed_subscription_groups
    @confirmed_subscription_groups ||= SubscriptionGroup.where(season: self).confirmed
  end

  def confirmed_subscription_groups_size
    confirmed_subscription_groups.size
  end

  def active_subscription_size
    active_subscriptions.size
  end

  def confirmed_subscription_size
    registered_subscriptions.not_canceled.size
  end

  def unconfirmed_subscription_size
    active_subscriptions.inquired(self).size
  end

  def canceled_subscriptions_size
    subscriptions.where(status: 2).size
  end

  def course_subscriptions
    active_subscriptions.includes(:courses).where.not(courses: {id: nil})
  end

  def workshop_subscriptions
    all_workshop_subscriptions.adults
  end

  def youth_workshop_subscriptions
    all_workshop_subscriptions.youth
  end

  def all_workshop_subscriptions
    @workshop_subscriptions ||= active_subscriptions.includes(:subbed_workshops).where.not(subbed_workshops: {id: nil})
  end

  def get_workshop_count(workshop_id)
    active_subscriptions.confirmed.not_canceled.where(workshop_slot: {workshop_id: workshop_id}).size
  end
end
