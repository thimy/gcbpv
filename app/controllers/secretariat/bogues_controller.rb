class Secretariat::BoguesController < SecretariatController
  include WithTableConcern

  before_action :query
  before_action :set_event, only: %i[ show edit update destroy ]

  SORT_ATTRIBUTES = ["created_at", "start_date"]

  # GET /events or /events.json
  def index
    set_tab_data
  end

  # GET /events/1 or /events/1.json
  def show
    @events = Event.where(bogue: @bogue)
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
        format.html { redirect_to secretariat_bogue_url(@bogue), notice: "L’événement a bien été enregistré." }
        format.json { render :show, status: :created, location: @bogue }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bogue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @bogue.update(bogue_params)
        @bogue.save_attachments
        format.html { redirect_to secretariat_bogue_url(@bogue), notice: "L’événement a bien été modifié." }
        format.json { render :show, status: :ok, location: @bogue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bogue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @bogue.destroy!

    respond_to do |format|
      format.html { redirect_to secretariat_events_url, notice: "L’événement a bien été supprimé." }
      format.json { head :no_content }
    end
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
    @bogue = Bogue.find(params[:bogue_id])
    SubscriptionMailer.custom_mail(@bogue).deliver_later

    respond_to do |format|
      format.html { redirect_to secretariat_bogue_url(@bogue) }
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
