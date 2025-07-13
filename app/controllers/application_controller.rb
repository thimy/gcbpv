class ApplicationController < ActionController::Base
  before_action :set_config

  private

  def set_config
    @config = Config.first
    @season = params[:season_name].present? && Season.find_by(start_year: params[:season_name].split("-").first) || @config.season
    @banner = @config.banner
    @season_links = Season.all.map {|season| {name: season.name, link: request.path.gsub!(@season.name, season.name)}}
  end
end
