class Ecole::MembershipController < EcoleController
  def index
    @plan = Config.first.season.plan
  end
end
