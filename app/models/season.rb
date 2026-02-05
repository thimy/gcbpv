class Season < ApplicationRecord
  belongs_to :plan

  validates :start_year, presence: true

  def name
    "#{start_year}-#{start_year+1}"
  end

  def student_count
    "#{Subscription.joins(:subscription_group).where(subscription_group: {season_id: Config.first.season.id}).size} élèves"
  end

  def subscription_groups
    SubscriptionGroup.where(season: self)
  end

  def unconfirmed_subscription_groups
    SubscriptionGroup.where(season: self).unconfirmed
  end

  def unconfirmed_subscription_groups_size
    unconfirmed_subscription_groups.size
  end

  def confirmed_subscription_groups
    SubscriptionGroup.where(season: self).confirmed
  end

  def confirmed_subscription_groups_size
    confirmed_subscription_groups.size
  end

  def active_subscriptions
    Subscription.active(self).not_on_hold
  end

  def active_subscription_size
    active_subscriptions.size
  end
  
  def confirmed_subscription_size
    active_subscriptions.registered(self).size
  end
  
  def unconfirmed_subscription_size
    active_subscriptions.inquired(self).size
  end

  def course_subscriptions
    active_subscriptions.includes(:courses).where.not(courses: {id: nil})
  end
  
  def workshop_subscriptions
    active_subscriptions.includes(:subbed_workshops).adults.where.not(subbed_workshops: {id: nil})
  end

  def youth_workshop_subscriptions
    active_subscriptions.includes(:subbed_workshops).youth.where.not(subbed_workshops: {id: nil})
  end
end
