class Ecole::MembershipController < BaseController
  def index
    @plan = Config.first.season.plan
  end
end
