class ApplicationController < ActionController::Base
  before_action :set_config

  def not_found
    raise ActionController::RoutingError.new('La page n’existe pas')
  end

  def redirect_to_signin
    redirect_to new_user_session_path
  end

  private

  def set_config
    @config = Config.first
    @season = params[:season_name].present? && Season.find_by(start_year: params[:season_name].split("-").first) || @config.season
    @banner = @config.banner
    @season_links = Season.all.map {|season| {name: season.name, link: request.path.gsub!(@season.name, season.name)}}
  end
end
