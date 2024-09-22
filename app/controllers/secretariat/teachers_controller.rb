class Secretariat::TeachersController < SecretariatController
  include WithTableConcern

  before_action :set_teacher, only: %i[ show edit update destroy get_slots ]

  SORT_ATTRIBUTES = [ "last_name" ]

  # GET /teachers or /teachers.json
  def index
    @instruments = params[:q].present? ? Instrument.where("name LIKE ?", "%#{params[:q]}%") : Instrument.all
    set_tab_data

    respond_to do |format|
      format.json
      format.html
    end
  end

  # GET /teachers/1 or /teachers/1.json
  def show
    @slots = @teacher.slots
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
    @instruments = Instrument.all
    @instrument_list = Instrument.all.map{|instrument|
      {
        value: instrument.id,
        text: instrument.name
      }
    }
  end

  # GET /teachers/1/edit
  def edit
    @selected_instruments = @teacher.instruments.map{|instrument| {text: instrument.name, value: instrument.id}}.to_json
    @instruments = Instrument.all
    @instrument_list = Instrument.all.map{|instrument|
      {
        value: instrument.id,
        text: instrument.name
      }
    }
  end

  # POST /teachers or /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to secretariat_teacher_url(@teacher), notice: "Le professeur a bien été créé." }
        format.json { render :show, status: :created, location: @teacher }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teachers/1 or /teachers/1.json
  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to secretariat_teacher_url(@teacher), notice: "Le professeur a bien été mis à jour." }
        format.json { render :show, status: :ok, location: @teacher }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_slots
    @slots = Slot.where(teacher: @teacher)

    render json: @slots.as_json(only: [:id, :slot_time, :day_of_week], include: { city: { only: :name }}), status: :ok
  end

  # DELETE /teachers/1 or /teachers/1.json
  def destroy
    @teacher.destroy!

    respond_to do |format|
      format.html { redirect_to secretariat_teachers_url, notice: "Le professeur a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  private

  def query
    params[:q]
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def teacher_params
      params.require(:teacher).permit(:first_name, :last_name, :email, :phone, :description, :photo, :instrument_ids => [])
    end

    def set_records
      filters = {}
      filters[:status] = params[:status] if params[:status].present?
      filters[:specialties] = Specialty.where(instrument: params[:instrument]) if params[:instrument].present?

      if !filters.empty?
        @filtered_teachers = Teacher.where(filters)
      else
        @filtered_teachers = Teacher.active
      end

      if query.present?
        @filtered_teachers = @filtered_teachers.where("last_name ILIKE ?", "%#{query}%").or(@filtered_teachers.where("first_name ILIKE ?", "%#{query}%"))
      end
      @selected_emails = @filtered_teachers.map {|teacher| teacher.email}.uniq.join(", ")
      @pagy, @teachers = paginate_records(@filtered_teachers)
    end

    def default_sort_attribute
      SORT_ATTRIBUTES.first
    end

    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES.include?(attribute)
    end
end
