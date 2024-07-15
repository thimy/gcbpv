class Ecole::TrainingsController < EcoleController
  before_action :set_training, only: %i[ show ]

  def index
    @trainings = Training.all
  end

  def show
    @other_trainings = Training.where.not(id: params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training
      @training = Training.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def training_params
      params.require(:training).permit(:name)
    end
end
