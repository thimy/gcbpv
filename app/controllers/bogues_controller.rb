class BoguesController < BaseController
  layout "bogue"
  
  before_action :set_bogue

  def show
    @events = @bogue.events.active.ordered
  end

  def schedule
    @events = @bogue.events.active.ordered
    @cities = @events.pluck(:city).uniq
  end

  def event
    @event = Event.find_by(slug: params[:event_slug], bogue: Bogue.find_by(slug: params[:bogue_slug]))
    render "event"
  end

  private

    def set_bogue
      @bogue = Bogue.find_by(slug: params[:bogue_slug])
    end
end
