# frozen_string_literal: true

class Secretariat::Navigation::Component < ViewComponent::Base
  include UriHelper
  
  def initialize(season: nil)
    @season = season
  end
end
