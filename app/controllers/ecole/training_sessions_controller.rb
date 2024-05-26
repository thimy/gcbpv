class Ecole::TrainingSessionsController < BaseController
  before_action :set_training_session, only: %i[ show ]

  def show
    @other_training_sessions = TrainingSession.where.not(id: params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training_session
      @training_session = TrainingSession.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def training_session_params
      params.require(:training_session).permit(:name)
    end
end
