class EcoleController < ApplicationController
  layout "ecole"

  def index
  end

  def pricing
    @plan = @season.plan.decorate
    @early_learning = PriceCategory.find_by(name: "Éveil").decorate
    @kid_discovery = PriceCategory.find_by(name: "Découverte instrumentale enfants").decorate
    @standalone = PriceCategory.find_by(name: "Ateliers autonomes").decorate
    @uillean_pipes = PriceCategory.find_by(name: "Uilleann pipes").decorate
  end

  def calendar
    @events = Event.upcoming.emt.reverse
  end
end
