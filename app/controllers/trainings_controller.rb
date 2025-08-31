class TrainingsController < SecretariatController
  include WithTableConcern

  before_action :authenticate_admin
  before_action :query
  before_action :set_training, only: %i[ show edit update destroy ]

  SORT_ATTRIBUTES = ["created_at", "start_date"]

  # GET /trainings or /trainings.json
  def index
    set_tab_data
  end

  # GET /trainings/1 or /trainings/1.json
  def show
    @training_sessions = @training.training_sessions.active
  end

  # GET /trainings/new
  def new
    @training = Training.new
    @seasons = Season.all
  end

  # GET /trainings/1/edit
  def edit
    @seasons = Season.all
  end

  # POST /trainings or /trainings.json
  def create
    @training = Training.new(training_params)
    @seasons = Season.all

    respond_to do |format|
      if @training.save
        @training.save_attachments
        format.html { redirect_to training_url(@training), notice: "La thématique rendez-vous a bien été enregistrée." }
        format.json { render :show, status: :created, location: @training }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trainings/1 or /trainings/1.json
  def update
    @seasons = Season.all
    respond_to do |format|
      if @training.update(training_params)
        @training.save_attachments
        format.html { redirect_to training_url(@training), notice: "La thématique a bien été modifiée." }
        format.json { render :show, status: :ok, location: @training }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @training.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trainings/1 or /trainings/1.json
  def destroy
    @training.destroy!

    respond_to do |format|
      format.html { redirect_to trainings_url, notice: "La thématique a bien été supprimée." }
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

  def send_training
    @training = Training.find(params[:training_id])
    SubscriptionMailer.custom_mail(@training).deliver_later

    respond_to do |format|
      format.html { redirect_to training_url(@training) }
    end
  end

  private

    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_training
      @training = Training.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def training_params
      params.require(:training).permit(:name, :content, :session_count, :price, :status, :comment, :season_id)
    end
    
    def set_records
      @pagy, @trainings = paginate_records(Training.all)
    end
    
    def default_sort_attribute
      SORT_ATTRIBUTES.first
    end

    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES.include?(attribute)
    end
end
