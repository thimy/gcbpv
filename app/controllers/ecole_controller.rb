class EcoleController < ApplicationController
  layout "ecole"

  def index
  end

  def pricing
    @early_learning = PriceCategory.find_by(name: "Éveil")
    @kid_discovery = PriceCategory.find_by(name: "Découverte instrumentale enfants")
    @standalone = PriceCategory.find_by(name: "Ateliers autonomes")
    @uillean_pipes = PriceCategory.find_by(name: "Uilleann pipes")
  end
end
