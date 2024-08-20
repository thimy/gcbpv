class ApplicationController < ActionController::Base
  before_action :set_config

  private

  def set_config
    @config = Config.first
    @season = @config.season
    @banner = @config.banner
  end
end
