class WorkshopSlotsController < SecretariatController
  include WithTableConcern

  before_action :query
  before_action :set_workshop_slot, only: %i[ show edit update destroy ]
  before_action :set_workshop, only: %i[ new create edit ]
  before_action :set_students, only: %i[ new edit ]
  before_action :set_teachers, only: %i[ new edit ]

  SORT_ATTRIBUTES = ["created_at", "start_date"]

  # GET /workshop_slots/1 or /workshop_slots/1.json
  def show
  end

  # GET /workshop_slots/new
  def new
    @workshop_slot = WorkshopSlot.new
    @cities = City.active
  end

  # GET /workshop_slots/1/edit
  def edit
    @cities = City.active
    @selected_students = @workshop_slot.students.map{|student| {text: student.name, value: student.id}}.to_json
    @selected_teachers = @workshop_slot.teachers.map{|teacher| {text: teacher.name, value: teacher.id}}.to_json
  end

  # POST /workshop_slots or /workshop_slots.json
  def create
    @cities = City.active
    @workshop = Workshop.find(params[:workshop_id])
    @workshop_slot = WorkshopSlot.new(workshop_slot_params)

    WorkshopSlot.transaction do
      respond_to do |format|
        if @workshop_slot.save
          params[:student_ids]&.each do |id|
            SubbedWorkshop.where(subscription: Subscription.active(@season).where(student: id), workshop_slot: WorkshopSlot.where(workshop: @workshop)).update(workshop_slot_id: @workshop_slot.id)
          end
          format.html { redirect_to workshop_path(@workshop), notice: "Le créneau a bien été enregistré." }
          format.json { render :show, status: :created, location: @workshop_slot }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @workshop_slot.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /workshop_slots/1 or /workshop_slots/1.json
  def update
    @cities = City.active

    WorkshopSlot.transaction do
      respond_to do |format|
        if @workshop_slot.update(workshop_slot_params)
            params[:student_ids]&.each do |id|
              SubbedWorkshop.where(subscription: Subscription.active(@season).where(student: id), workshop_slot: WorkshopSlot.where(workshop: @workshop)).update(workshop_slot_id: @workshop_slot.id)
            end
          format.html { redirect_to workshop_path(@workshop), notice: "Le créneau a bien été modifié." }
          format.json { render :show, status: :ok, location: @workshop_slot }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @workshop_slot.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /workshop_slots/1 or /workshop_slots/1.json
  def destroy
    @workshop_slot.destroy!

    respond_to do |format|
      format.html { redirect_to secretariat_workshop_url(@workshop), notice: "Le créneau a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  def upload_file
    file_params = {
      file: params[:file] || params[:image]
    }

    if params[:file].present?
      file_params[:name] = params[:file].original_filename if params[:file].original_filename.present?
      file_params[:extension] = Rack::Mime::MIME_TYPES.invert[params[:file].content_type].sub(".", "") if params[:file].content_type.present?
      file_params[:size] = params[:file].size if params[:file].size.present?
    end

    if file_params[:file].nil?
      render json: { success: 0, error: "Pas de fichier dans cette requête" }
      return
    end

    uploaded_file = Attachment.create!(file_params)
    stored_file_url = rails_blob_url(uploaded_file.file)

    response_params = {
      url: stored_file_url
    }
    response_params[:name] = uploaded_file.name if uploaded_file.name.present?
    response_params[:extension] = uploaded_file.extension if uploaded_file.extension.present?
    response_params[:size] = uploaded_file.size if uploaded_file.size.present?

    render json: { success: 1, file: response_params }
  rescue StandardError => e
    render json: { success: 0, error: e.message }
  end

  private

    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_workshop_slot
      @workshop_slot = WorkshopSlot.find(params[:id])
      @workshop = Workshop.find(params[:workshop_id]) || @workshop_slot.workshop
    end

    def set_workshop
      @workshop = Workshop.find(params[:workshop_id])
    end

    def set_students
      @students = @workshop.students.includes(:subscriptions).where(subscriptions: {subscription_group: SubscriptionGroup.where(season: @season)}).order(:last_name)
      @student_list = @students.map{|student|
        {
          value: student.id,
          text: student.name
        }
      }
    end

    def set_teachers
      @teachers = Teacher.all.order(:last_name)
      @teacher_list = @teachers.map{|teacher|
        {
          value: teacher.id,
          text: teacher.name
        }
      }
    end

    # Only allow a list of trusted parameters through.
    def workshop_slot_params
      params[:workshop_slot][:workshop_id] = params[:workshop_id]
      params.require(:workshop_slot).permit(:workshop_id, :city_id, :slot_time, :day_of_week, :frequency, :status, :comment, :is_custom, :teacher_ids => [])
    end
    
    def set_records
      @pagy, @workshop_slots = paginate_records(WorkshopSlot.ordered)
    end
    
    def default_sort_attribute
      SORT_ATTRIBUTES.first
    end

    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES.include?(attribute)
    end
end
