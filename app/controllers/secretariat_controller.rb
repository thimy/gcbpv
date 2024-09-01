class SecretariatController < ApplicationController
  layout "secretariat"

  before_action :set_season

  def index
    @subscription_groups = SubscriptionGroup.where(season: @season)
    @unconfirmed_subscription_groups = SubscriptionGroup.where(season: @season).unconfirmed
    @unconfirmed_subscription_groups_size = @unconfirmed_subscription_groups.size
    @confirmed_subscription_groups = SubscriptionGroup.where(season: @season).confirmed
    @confirmed_subscription_groups_size = @confirmed_subscription_groups.size

    @active_subscriptions = Subscription.active
    @active_subscription_size = @active_subscriptions.size
    @confirmed_subscription_size = @active_subscriptions.registered.size
    @unconfirmed_subscription_size = @active_subscriptions.inquired.size

    @teachers = Teacher.active.includes(:slots)
    @workshops = Workshop.active
    @kid_workshops = KidWorkshop.active
  end

  private

  def set_season
    @season = Config.first.season
  end

end
