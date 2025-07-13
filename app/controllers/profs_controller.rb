class ProfsController < ApplicationController
  layout "profs"

  before_action :authenticate_user!
  before_action :set_teacher

  def index
    @courses = Course.active(@season).includes(:slot).where(slot: {teacher: @teacher})
  end

  private

  def set_teacher
    @teacher = current_user.teacher
  end
end
