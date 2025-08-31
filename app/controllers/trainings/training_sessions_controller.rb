class Trainings::TrainingSessionsController < SecretariatController
  include WithTableConcern

  before_action :query
  before_action :set_training_session, only: %i[ show edit update destroy ]

  SORT_ATTRIBUTES = ["created_at", "start_date"]

  # GET /training_sessions/1 or /training_sessions/1.json
  def show
  end

  # GET /training_sessions/new
  def new
    @training = Training.find(params[:training_id])
    @training_session = TrainingSession.new
  end

  # GET /training_sessions/1/edit
  def edit
  end

  # POST /training_sessions or /training_sessions.json
  def create
    @training = Training.find(params[:training_id])
    @training_session = TrainingSession.new(training_session_params)

    respond_to do |format|
      if @training_session.save
        @training_session.save_attachments
        format.html { redirect_to training_path(@training), notice: "Le rendez-vous a bien été enregistré." }
        format.json { render :show, status: :created, location: @training_session }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @training_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /training_sessions/1 or /training_sessions/1.json
  def update
    respond_to do |format|
      if @training_session.update(training_session_params)
        @training_session.save_attachments
        format.html { redirect_to training_path(@training), notice: "Le rendez-vous a bien été modifié." }
        format.json { render :show, status: :ok, location: @training_session }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @training_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training_sessions/1 or /training_sessions/1.json
  def destroy
    @training_session.destroy!

    respond_to do |format|
      format.html { redirect_to secretariat_training_url(@training), notice: "Le rendez-vous a bien été supprimé." }
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

  private

    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_training_session
      @training_session = TrainingSession.find(params[:id])
      @training = Training.find(params[:training_id]) || @training_session.training
    end

    # Only allow a list of trusted parameters through.
    def training_session_params
      params[:training_session][:training_id] = params[:training_id]
      params.require(:training_session).permit(:name, :content, :status, :image, :date, :location, :city, :comment, :training_id, :guest)
    end
    
    def set_records
      @pagy, @training_sessions = paginate_records(TrainingSession.ordered)
    end
    
    def default_sort_attribute
      SORT_ATTRIBUTES.first
    end

    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES.include?(attribute)
    end
end
