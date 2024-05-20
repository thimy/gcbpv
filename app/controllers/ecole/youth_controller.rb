class Ecole::YouthController < WebsiteController
  def index
    @kid_workshops = KidWorkshop.visible
    @plan = Config.first.season.plan
  end
end
