class BaseController < ApplicationController
  include UriHelper

  layout "website"

  before_action :set_season

  private

  def set_season
    @season = params[:season].present? ? Season.where(start_year: params[:season].split("-").first).first : Config.first.season
  end
end
