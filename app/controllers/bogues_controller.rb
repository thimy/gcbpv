class BoguesController < SecretariatController
  include WithTableConcern
  include WithFileConcern

  before_action :authenticate_admin
  before_action :query
  before_action :set_event, only: %i[ show edit update destroy ]

  SORT_ATTRIBUTES = ["created_at", "start_date"]

  # GET /events or /events.json
  def index
    set_tab_data
  end

  # GET /events/1 or /events/1.json
  def show
    @events = Event.where(bogue: @bogue).ordered
    @pages = Page.where(bogue: @bogue)
  end

  # GET /events/new
  def new
    @bogue = Bogue.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @bogue = Bogue.new(bogue_params)

    respond_to do |format|
      if @bogue.save
        @bogue.save_attachments
        format.html { redirect_to bogue_url(@bogue), notice: "L’événement a bien été enregistré." }
        format.json { render :show, status: :created, location: @bogue }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @bogue.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @bogue.update(bogue_params)
        @bogue.save_attachments
        format.html { redirect_to bogue_url(@bogue), notice: "L’événement a bien été modifié." }
        format.json { render :show, status: :ok, location: @bogue }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @bogue.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @bogue.destroy!

    respond_to do |format|
      format.html { redirect_to events_url, notice: "L’événement a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  def send_event
    @bogue = Bogue.find(params[:bogue_id])
    SubscriptionMailer.custom_mail(@bogue).deliver_later

    respond_to do |format|
      format.html { redirect_to bogue_url(@bogue) }
    end
  end

  private

    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @bogue = Bogue.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bogue_params
      params[:bogue][:slug] = "bogue-#{Date.parse(params[:bogue][:start_date]).year}"
      params.require(:bogue).permit(:name, :content, :status, :file, :start_date, :end_date, :slug)
    end
    
    def set_records
      @pagy, @bogues = paginate_records(Bogue.ordered)
    end
    
    def default_sort_attribute
      SORT_ATTRIBUTES.first
    end

    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES.include?(attribute)
    end
end
