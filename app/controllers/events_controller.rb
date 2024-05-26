class EventsController < BaseController
  before_action :set_event, only: %i[ show ]

  def index
    @upcoming_events = Event.upcoming
    @passed_events = Event.passed
  end

  def show
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
