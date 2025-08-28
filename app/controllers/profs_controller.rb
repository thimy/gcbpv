class ProfsController < ApplicationController
  layout "profs"

  before_action :authenticate_user!
  before_action :set_teacher

  def index
    @courses = Course.active(@season).includes(:slot).where(slot: {teacher: @teacher})
  end

  def profile
  end

  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_teacher
    @teacher = current_user.teacher || not_found
    params[:season_name] = @season.name if params[:season_name].nil?
  end

  # Only allow a list of trusted parameters through.
    def teacher_params
      params.require(:teacher).permit(:first_name, :last_name, :description, :photo)
    end
end
