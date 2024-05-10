class Ecole::ProjectsController < WebsiteController
  before_action :set_project, only: %i[ show ]

  def index
    @projects = Project.where(public: true)
  end

  def show
    @other_projects = Project.where.not(id: params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name)
    end
end
