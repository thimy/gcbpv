class EventsController < BaseController
  before_action :set_event, only: %i[ show ]

  def index
    @upcoming_events = Event.ordered.upcoming
    @passed_events = Event.ordered.passed
  end

  def show
    @posts = Post.latest.where(event: @event)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name)
    end
end
