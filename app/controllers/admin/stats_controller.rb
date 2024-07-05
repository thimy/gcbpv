module Admin
  class StatsController < Admin::ApplicationController
    def index
      @season = Config.first.season
      @subscription_groups = SubscriptionGroup.where(season: @season).count
      @subscriptions = Subscription.joins(:subscription_group).where(subscription_group: {season: @season}).count
      @teachers = Teacher.active.includes(:slots)
      @workshops = Workshop.active
      @kid_workshops = KidWorkshop.active
    end
  end
end
