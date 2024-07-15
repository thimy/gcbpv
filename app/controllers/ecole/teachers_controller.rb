class Ecole::TeachersController < EcoleController
  before_action :set_teacher, only: %i[ show ]

  def index
    @teachers = Teacher.active
  end

  def show
    @other_teachers = Teacher.active.where.not(id: params[:id]).order(:last_name)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def teacher_params
      params.require(:teacher).permit(:name)
    end
end
