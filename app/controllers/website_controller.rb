class WebsiteController < ApplicationController
  def index
    @posts = Post.latest.limit(3) 
    @events = Event.ordered.upcoming.limit(5).reverse
    render layout: "home"
  end
end
