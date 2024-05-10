class WebsiteController < ApplicationController
  layout "website"

  def index
    @posts = Post.latest.limit(3) 
    @events = Event.upcoming.limit(3).reverse
  end
end
