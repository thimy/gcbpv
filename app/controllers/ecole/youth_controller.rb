class Ecole::YouthController < EcoleController
  def index
    @plan = Config.first.season.plan
    @early_learning = KidWorkshop.find_by(name: "Éveil musical")
    @kid_discovery = KidWorkshop.find_by(name: "Découverte instrumentale enfants")
    @kid_workshops = Workshop.active.where(kid_friendly: true)
  end
end
