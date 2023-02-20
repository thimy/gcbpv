class PublicController < ApplicationController
  def index
    now = Time.now
    @events = Event.where("start_date >= :date OR updated_at >= :date", date: now).last(3)
    @posts = Post.all
  end
end
