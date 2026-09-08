class TrainingsController < SecretariatController
  include WithTableConcern
  include WithFileConcern

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
    @training_sessions = @training.training_sessions.active(@season)
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
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @training.errors, status: :unprocessable_content }
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
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @training.errors, status: :unprocessable_content }
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
      @pagy, @trainings = paginate_records(Training.active(@season))
    end
end
