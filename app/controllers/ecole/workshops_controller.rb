class Ecole::WorkshopsController < EcoleController
  before_action :set_workshop, only: %i[ show ]

  def index
    @workshops = Workshop.all
  end

  def show
    @other_workshops = Workshop.where.not(id: params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workshop
      @workshop = Workshop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def workshop_params
      params.require(:workshop).permit(:name)
    end
end
