class ProjectsController < SecretariatController
  include WithTableConcern

  before_action :authenticate_admin
  before_action :set_project, only: %i[ show edit update destroy edit_project show_project ]
  before_action :set_students, only: %i[ new edit ]

  SORT_ATTRIBUTES = ["created_at", "start_date"]

  # GET /projects or /projects.json
  def index
    set_tab_data
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    @seasons = Season.all
  end

  # GET /projects/1/edit
  def edit
    @seasons = Season.all
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Le projet a été créé avec succès." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Le projet a été mis à jour avec succès." }
        format.json { render :show, status: :ok, location: @project }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Le projet a été supprimé avec succès." }
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

  def edit_project
  end

  def show_project
  end

  private
    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id] || params[:project_id])
    end

    def set_students
      @students = Student.order(:last_name)
      @student_list = @students.map{|student|
        {
          value: student.id,
          text: student.name
        }
      }
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :content, :status, :season_id, :comment, :student_ids => [])
    end

    def set_records
      @pagy, @projects = paginate_records(Project.all)
    end
end
