class EventsController < SecretariatController
  include WithTableConcern
  include WithFileConcern

  before_action :authenticate_admin
  before_action :query
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :set_bogues, only: %i[ new edit update create ]

  SORT_ATTRIBUTES = ["created_at", "start_date"]

  # GET /events or /events.json
  def index
    set_tab_data
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        @event.save_attachments
        format.html { redirect_to event_url(id: @event.id), notice: "L’événement a bien été enregistré." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @event.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        @event.save_attachments
        format.html { redirect_to event_url(id: @event.id), notice: "L’événement a bien été modifié." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @event.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_url, notice: "L’événement a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  def send_event
    @event = Event.find(params[:event_id])
    SubscriptionMailer.custom_mail(@event).deliver_later

    respond_to do |format|
      format.html { redirect_to event_url(@event) }
    end
  end

  private

    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def set_bogues
      @bogues = Bogue.all
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :content, :status, :file, :start_date, :end_date, :location, :organizer, :website, :comment, :city, :bogue_id, :is_emt)
    end
    

    def set_records
      @pagy, @events = paginate_records(Event.ordered)
    end
    
    def default_sort_attribute
      SORT_ATTRIBUTES.first
    end

    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES.include?(attribute)
    end
end
