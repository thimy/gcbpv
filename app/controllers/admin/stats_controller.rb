module Admin
  class StatsController < Admin::ApplicationController
    def index
      @season = Config.first.season
      @subscription_groups = SubscriptionGroup.where(season: @season).count
      @subscriptions = Subscription.where(subscription_group: @subscription_groups).count
      @teachers = Teacher.active.includes(:slots)
      @workshops = Workshop.active
    end
  end
end
