class SecretariatController < ApplicationController
  layout 'secretariat'

  before_action :set_season
  before_action :authenticate_admin

  def authenticate_admin
    redirect_to_signin if current_user.nil?
  end

  def index
    @seasons = SeasonDecorator.decorate_collection(Season.includes(subscription_groups: { subscriptions: [:courses, :subbed_workshops] }).all.sort_by {it.start_year}.reverse)
  end

  private

  def set_season
    @season = params[:season_name].present? && Season.find_by(start_year: params[:season_name].split('-').first) || Config.first.season
    @season_links = Season.all.map {|season| {name: season.name, link: request.path.gsub!(@season.name, season.name)}}
  end
end
