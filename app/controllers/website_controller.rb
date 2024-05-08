class WebsiteController < ApplicationController
  layout "website"

  def index
    @events = Event.upcoming.limit(3)
  end
end
