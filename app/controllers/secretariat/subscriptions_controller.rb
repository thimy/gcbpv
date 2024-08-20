class Secretariat::SubscriptionsController < SecretariatController
  include WithTableConcern

  before_action :query
  before_action :set_subscription, only: %i[ show edit update destroy ]
  before_action :set_lists, only: %i[ new create edit add_course add_workshop ]

  SORT_ATTRIBUTES = {
    "subscriptions" => [
      "student",
    ]
  }

  # GET /subscriptions or /subscriptions.json
  def index
    @instruments = Instrument.active
    @workshops = Workshop.active
    set_tab_data
  end

  # GET /subscriptions/1 or /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions or /subscriptions.json
  def create
    new_params = {id: params[:id]}
    if student_params.present?
      new_params[:student] = Student.new(student_params)
    else
      new_params[:student_id] = Student.find_by(first_name: student_params[:first_name], last_name: student_params[:last_name]).id
    end
    @subscription_group = SubscriptionGroup.joins(:payor).find_by(season: @season, payor: {first_name: payor_params[:first_name], last_name: payor_params[:last_name]})
    if @subscription_group.present?
      new_params[:subscription_group_id] = @subscription_group.id
    else
      @payor = Payor.new(payor_params)
      new_params[:subscription_group] = SubscriptionGroup.new(season: @season, payor: @payor)
    end
    @subscription = Subscription.new(new_params.merge(subscription_params))

    respond_to do |format|
      if params[:add_course]
        @subscription.courses.build
        format.html { render :new, status: :unprocessable_entity }
      elsif params[:add_workshop]
        @subscription.subbed_workshops.build
        format.html { render :new, status: :unprocessable_entity }
      else
        if @subscription.save
          format.html { redirect_to secretariat_subscription_url(@subscription), notice: "L’inscription a bien été enregistrée." }
          format.json { render :show, status: :created, location: @subscription }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @subscription.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /subscriptions/1 or /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to subscription_url(@subscription), notice: "L’inscription a bien été modifiée." }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1 or /subscriptions/1.json
  def destroy
    @subscription.destroy!

    respond_to do |format|
      format.html { redirect_to secretariat_subscriptions_url, notice: "L’inscription a bien été supprimée." }
      format.json { head :no_content }
    end
  end

  def add_course
    @subscription = Subscription.new(subscription_params.merge({id: params[:id]}))
    @subscription.courses.build
    render :new
  end

  def add_workshop
    @subscription = Subscription.new(subscription_params.merge({id: params[:id]}))
    @subscription.subbed_workshops.build
    render :new
  end

  def update_teachers
    @teachers = Teacher.where(specialties: Specialty.where(instrument: Instrument.find(params[:instrument_id])))

    render json: @teachers.as_json(only: [:first_name, :last_name, :id]), status: :ok
  end

  def update_slots
    @slots = Slot.where(teacher: params[:teacher_id])

    render json: @slots.as_json(only: [:id, :slot_time], include: { city: { only: :name }}), status: :ok
  end

  def update_workshop_slots
    @slots = WorkshopSlot.where(workshop: params[:workshop_id])

    render json: @slots.as_json(only: [:id, :slot_time], include: { city: { only: :name }}), status: :ok
  end

  def update_kid_workshop_slots
    @slots = KidWorkshopSlot.where(kid_workshop: params[:kid_workshop_id])

    render json: @slots.as_json(only: [:id, :slot_time], include: { city: { only: :name }}), status: :ok
  end

  private

    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      params.require(:subscription).permit(:student_id, :subscription_group_id, :ars, :disability, :image_consent, :comment, courses_attributes: [:instrument_id, :slot_id, :option, :comment], subbed_workshops_attributes: [:workshop_slot_id, :option, :comment], subbed_kid_workshops_attributes: [:kid_workshop_slot_id, :option, :comment])
    end

    def student_params
      if params[:student].present?
        if params[:student][:name].present?
          name_params = params[:student][:name].split(/ /, 2)
          params[:student][:first_name] = name_params.first
          params[:student][:last_name] = name_params.last
          params[:student].delete(:name)
        end
        params.require(:student).permit(:first_name, :last_name, :gender, :phone, :email, :comment)
      end
    end

    def payor_params
      if params[:payor].present?
        if params[:payor][:name].present?
          name_params = params[:payor][:name].split(/ /, 2)
          params[:payor][:first_name] = name_params.first
          params[:payor][:last_name] = name_params.last
          params[:payor].delete(:name)
        end
        params.require(:payor).permit(:first_name, :last_name, :phone, :email, :address, :postcode, :city, :comment)
      end
    end

    def set_lists
      @students = Student.all
      @payors = Payor.all
      @instruments = Instrument.active
      @workshops = Workshop.active
      @kid_workshops = KidWorkshop.active
    end

    def set_records
      @filtered_courses = params[:instrument].present? ? Course.where(instrument: params[:instrument]) : Course.all
      @filtered_workshops = params[:workshop].present? ? SubbedWorkshop.joins(:workshop_slot).where(workshop_slot: { workshop: params[:workshop] }) : SubbedWorkshop.all
      if query.present? 
        @pagy, @subscriptions = paginate_records(Subscription.joins(:subscription_group).where(subscription_group: { season: @season }, courses: @filtered_courses, subbed_workshops: @filtered_workshops, student: Student.where("last_name ILIKE ?", "%#{query}%")).or(Subscription.joins(:subscription_group).where(subscription_group: { season: @season }, courses: @filtered_courses, subbed_workshops: @filtered_workshops, student: Student.where("first_name ILIKE ?", "%#{query}%"))))
      else
        @pagy, @subscriptions = paginate_records(Subscription.joins(:subscription_group).where(subscription_group: { season: @season }, courses: @filtered_courses, subbed_workshops: @filtered_workshops))
      end
    end
    
    def default_sort_attribute
      SORT_ATTRIBUTES["subscriptions"].first
    end

    def with_sort_params(records)
      if @sort_attribute.present?
        records.joins(:student).merge(Student.order(last_name: @sort_direction))
      else
        records
      end
    end
  
    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES["subscriptions"].include?(attribute)
    end
end
