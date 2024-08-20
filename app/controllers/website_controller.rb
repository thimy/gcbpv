class WebsiteController < ApplicationController
  
  def index
    @posts = Post.latest.limit(3) 
    @events = Event.upcoming.limit(3).reverse
    render layout: "home"
  end

  def contact
  end
end
