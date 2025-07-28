class EventsController < SecretariatController
  include WithTableConcern

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
  end

  # GET /events/new
  def new
    @event = Event.new
    @bogues = Bogue.all
  end

  # GET /events/1/edit
  def edit
    @bogues = Bogue.all
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        @event.save_attachments
        format.html { redirect_to event_url(@event), notice: "L’événement a bien été enregistré." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        @event.save_attachments
        format.html { redirect_to event_url(@event), notice: "L’événement a bien été modifié." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
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

  def upload_image
    image = params[:image]

    if image.nil?
      render json: { success: 0, error: "Pas d’image dans cette requête" }
      return
    end

    uploaded_image = EventImage.create!(image: image)
    stored_image_url = rails_blob_url(uploaded_image.image)

    render json: { success: 1, file: { url: stored_image_url } }
  rescue StandardError => e
    render json: { success: 0, error: e.message }
  end

  def upload_file
    file_params = {
      file: params[:file] || params[:image]
    }

    if params[:file].present?
      file_params[:name] = params[:file].original_filename if params[:file].original_filename.present?
      file_params[:extension] = Rack::Mime::MIME_TYPES.invert[params[:file].content_type].sub(".", "") if params[:file].content_type.present?
      file_params[:size] = params[:file].size if params[:file].size.present?
    end

    if file_params[:file].nil?
      render json: { success: 0, error: "Pas de fichier dans cette requête" }
      return
    end

    uploaded_file = Attachment.create!(file_params)
    stored_file_url = rails_blob_url(uploaded_file.file)

    response_params = {
      url: stored_file_url
    }
    response_params[:name] = uploaded_file.name if uploaded_file.name.present?
    response_params[:extension] = uploaded_file.extension if uploaded_file.extension.present?
    response_params[:size] = uploaded_file.size if uploaded_file.size.present?

    render json: { success: 1, file: response_params }
  rescue StandardError => e
    render json: { success: 0, error: e.message }
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

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :content, :status, :file, :start_date, :end_date, :location, :organizer, :website, :comment, :city, :bogue_id)
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
