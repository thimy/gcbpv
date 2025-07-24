class Website::BogueController < BaseController
  layout "bogue"
  
  before_action :set_bogue

  def show
    @events = @bogue.events.active.ordered
  end

  def highlights
    @events = @bogue.events.active.where(highlight: true).ordered
  end

  def schedule
    @filters = {}
    @filters[:event_type] = Event.event_types.key(params[:type].to_i) if params[:type].present?
    @filters[:city] = params[:ville] if params[:ville].present?
    @events = @bogue.events.where(@filters).active.upcoming.ordered.reverse
    @passed_events = @bogue.events.where(@filters).active.passed.ordered
    @cities = @bogue.events.active.pluck(:city).uniq
  end

  def event
    @event = Event.find_by(slug: params[:event_slug], bogue: Bogue.find_by(slug: params[:bogue_slug]))
    render "event"
  end

  def page
    @page = Page.find_by(slug: params[:page_slug], bogue: Bogue.find_by(slug: params[:bogue_slug])) || not_found
  end

  def contests
    @contests = @bogue.events.where(event_type: "Concours", parent_event_id: nil)
    render "contests"
  end

  private

    def set_bogue
      @bogue = Bogue.find_by(slug: params[:bogue_slug]) || not_found
    end
end
