class Ecole::YouthController < BaseController
  def index
    @kid_workshops = KidWorkshop.visible
    @plan = Config.first.season.plan
  end
end
