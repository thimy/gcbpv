class SecretariatController < ApplicationController
  layout "secretariat"

  before_action :set_season
  before_action :authenticate_admin
  skip_before_action :authenticate_admin, only: [:index]

  def authenticate_admin
    not_found if current_administrator.nil?
    authenticate_administrator!
  end

  def index
    authenticate_administrator!
    @seasons = Season.all.reverse
    @subscription_groups = SubscriptionGroup.where(season: @season)
    @unconfirmed_subscription_groups = SubscriptionGroup.where(season: @season).unconfirmed
    @unconfirmed_subscription_groups_size = @unconfirmed_subscription_groups.size
    @confirmed_subscription_groups = SubscriptionGroup.where(season: @season).confirmed
    @confirmed_subscription_groups_size = @confirmed_subscription_groups.size

    @active_subscriptions = Subscription.active(@season)
    @active_subscription_size = @active_subscriptions.size
    @confirmed_subscription_size = @active_subscriptions.registered(@season).size
    @unconfirmed_subscription_size = @active_subscriptions.inquired(@season).size

    @teachers = Teacher.active.includes(:slots)
    @workshops = Workshop.active
    @kid_workshops = KidWorkshop.active
  end

  private

  def set_season
    @season = params[:season_name].present? && Season.find_by(start_year: params[:season_name].split("-").first) || Config.first.season
    @season_links = Season.all.map {|season| {name: season.name, link: request.path.gsub!(@season.name, season.name)}}
  end
end
