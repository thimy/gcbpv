module Admin
  class StatsController < Admin::ApplicationController
    def index
      @season = Config.first.season
      @subscription_groups = SubscriptionGroup.where(season: @season)
      @unconfirmed_subscription_groups = SubscriptionGroup.where(season: @season).unconfirmed
      @unconfirmed_subscription_groups_size = @unconfirmed_subscription_groups.size
      @confirmed_subscription_groups = SubscriptionGroup.where(season: @season).confirmed
      @confirmed_subscription_groups_size = @confirmed_subscription_groups.size
      @confirmed_subscription_size = Subscription.includes(:subscription_group).where.not(subscription_group: {status: 0, season: @season}).size
      @unconfirmed_subscription_size = Subscription.includes(:subscription_group).where(subscription_group: {status: 0, season: @season}).size
      @teachers = Teacher.active.includes(:slots)
      @workshops = Workshop.adults.active
      @kid_workshops = KidWorkshop.active
    end
  end
end
