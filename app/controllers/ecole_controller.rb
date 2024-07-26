class EcoleController < ApplicationController
  layout "ecole"

  def index
  end

  def pricing
    @season = Config.first.season
  end
end
