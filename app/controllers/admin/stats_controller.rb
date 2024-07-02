module Admin
  class StatsController < Admin::ApplicationController
    def index
      @season = Config.first.season
      @subscription_groups = SubscriptionGroup.where(season: @seaon)
      @subscriptions = Subscription.where(subscription_group: @subscription_groups)
      @teachers = Teacher.active
      @workshops = Workshop.active
    end
  end
end
