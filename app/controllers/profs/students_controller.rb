class Profs::StudentsController < ProfsController

  before_action :set_teacher
  before_action :set_student
  before_action :set_season

  # GET /subscriptions/1 or /subscriptions/1.json
  def show
    @courses = Course.active(@season).includes(:slot, :subscription).where(slot: {teacher: @teacher}, subscription: {student: @student})
    @workshops = @teacher.workshop_slots.includes(:subbed_workshops).where(subbed_workshops: {subscription: Subscription.active(@season).where(student: @student)})
  end

  private

  def set_teacher
    @teacher = current_user.teacher
  end

  def set_student
    @student = Student.find(params[:id])
  end

  def set_season
    @season = params[:season_name].present? && Season.find_by(start_year: params[:season_name].split("-").first) || Config.first.season
    @season_links = Season.all.map {|season| {name: season.name, link: request.path.gsub!(@season.name, season.name)}}
  end
end
