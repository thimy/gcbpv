module Admin
  class FichesProfsController < Admin::ApplicationController
    before_action :set_teacher, only: %i[ show edit update destroy ]

    def index
      @season = Config.first.season
      @teachers = Teacher.active
    end

    def show
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_teacher
        @teacher = Teacher.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def teacher_params
        params.require(:teacher).permit(:first_name, :last_name, :email, :phone, :instrument_id, :description, :photo)
      end
  end
end
