class WebsiteController < ApplicationController
  layout "home"

  def index
    @posts = Post.latest.limit(3) 
    @events = Event.upcoming.limit(3).reverse
  end
end
