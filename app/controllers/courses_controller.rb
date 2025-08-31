class CoursesController < SecretariatController
  before_action :authenticate_admin
  before_action :set_course, only: %i[ show edit update destroy edit_time show_time ]

  # GET /courses or /courses.json
  def index
    @season = Config.first.season
    @courses = Course.all
  end

  # GET /courses/1 or /courses/1.json
  def show
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          @course,
          partial: "courses/course", 
          locals: {
            course: @course,
            is_form: false
          }
        )
      end
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.before(
          "add-instrument",
          partial: "courses/course", 
          locals: {
            course: Course.new,
            instruments: Instrument.active,
            teachers: [],
            slots: [],
            is_form: true,
          }
        )
      end
    end
  end

  # GET /courses/1/edit
  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          @course,
          partial: "courses/course", 
          locals: {
            course: @course,
            instruments: Instrument.active,
            teachers: Teacher.where(specialties: Specialty.where(instrument: @course.instrument_id)),
            slots: Slot.where(teacher: @course.slot.teacher_id),
            is_form: true
          }
        )
      end
    end
  end

  # POST /courses or /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: "Le cours a bien été enregistré." }
        format.json { render :show, status: :created, location: @course }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "new_course",
            partial: "courses/course", 
            locals: {
              course: @course,
              is_form: false
            }
          )
        }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_back fallback_location: course_url(@course), notice: "Le cours a bien été modifié." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @subscription_id = @course.subscription_id
    @course.destroy!

    respond_to do |format|
      format.html { redirect_to secretariat_subscription_url(@subscription_id), notice: "Le cours a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  def edit_time
    render partial: "edit_time", locals: {course: @course}
  end

  def show_time
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      if params[:course].present? && params[:course][:teacher_id].present?
        params[:id] = params[:course][:id]
        params[:course].delete(:id)
        params[:course].delete(:teacher_id)
      end
      @course = Course.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:slot_id, :instrument_id, :start_time, :end_time, :option, :comment, :subscription_id, :frequency)
    end
end
