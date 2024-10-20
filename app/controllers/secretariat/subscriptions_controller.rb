class Secretariat::SubscriptionsController < SecretariatController
  include WithTableConcern

  before_action :query
  before_action :set_subscription, only: %i[ show edit update destroy ]
  before_action :set_lists, only: %i[ index new create show edit update add_course add_workshop ]

  SORT_ATTRIBUTES = {
    "subscriptions" => [
      "student",
    ]
  }

  # GET /subscriptions or /subscriptions.json
  def index
    set_tab_data
    @unconfirmed_count = Subscription.includes(:subscription_group).where(subscription_group: {status: 0, season: @season}).size
    @confirmed_count = Subscription.includes(:subscription_group).where.not(subscription_group: {status: 0, season: @season}).size
  end

  # GET /subscriptions/1 or /subscriptions/1.json
  def show
    @subbed_workshops = @subscription.subbed_workshops.ordered
    @subbed_kid_workshops = @subscription.subbed_kid_workshops.ordered
    @courses = @subscription.courses.ordered
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
    @student = @subscription.student
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
      if params[:add_kid_workshop]
        subbed_kid_workshop = SubbedKidWorkshop.new(subbed_kid_workshop_params.merge({subscription_id: params[:id]}))
        if subbed_kid_workshop.save
          format.html { redirect_to secretariat_subscription_url(@subscription), notice: "L’atelier enfant a bien été ajouté." }
          format.json { render :show, status: :created, location: @subscription }
        end
      end
      if params[:edit_kid_workshop]
        course = Course.new(course_params.merge({subscription_id: params[:id]}))
        if course.save
          format.html { redirect_to secretariat_subscription_url(@subscription), notice: "Le cours a bien été ajouté." }
          format.json { render :show, status: :created, location: @subscription }
        end
      end
      if params[:add_course]
        course = Course.new(course_params.merge({subscription_id: params[:id]}))
        if course.save
          format.html { redirect_to secretariat_subscription_url(@subscription), notice: "Le cours a bien été ajouté." }
          format.json { render :show, status: :created, location: @subscription }
        end
      end
      if params[:add_workshop]
        subbed_workshop = SubbedWorkshop.new(subbed_workshop_params.merge({subscription_id: params[:id]}))
        if subbed_workshop.save
          format.html { redirect_to secretariat_subscription_url(@subscription), notice: "L’atelier a bien été ajouté." }
          format.json { render :show, status: :created, location: @subscription }
        end
      end
      if params[:edit_kid_workshop]
        subbed_kid_workshop = SubbedKidWorkshop.find(params[:subbed_kid_workshop_id])
        if subbed_kid_workshop.update(subbed_kid_workshop_params)
          format.html { redirect_to secretariat_subscription_url(@subscription), notice: "L’atelier a bien été modifié." }
          format.json { render :show, status: :ok, location: @subscription }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @subscription.errors, status: :unprocessable_entity }
        end        
      end
      if @subscription.update(subscription_params)
        format.html { redirect_to secretariat_subscription_url(@subscription), notice: "L’inscription a bien été modifiée." }
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

  def add_kid_workshop
    @subscription = Subscription.new(subscription_params.merge({id: params[:id]}))
    @subscription.courses.build
    render :new
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
      params.require(:subscription).permit(:student_id, :subscription_group_id, :ars, :disability, :image_consent, :comment, courses_attributes: [:instrument_id, :slot_id, :option, :comment], subbed_workshops_attributes: [:workshop_slot_id, :option, :comment], subbed_kid_workshops_attributes: [:kid_workshop_slot_id, :option, :comment], subbed_kid_workshop_attributes: [:kid_workshop_slot_id, :option, :comment], student_attributes: [:first_name, :last_name, :phone, :email, :gender, :comment])
    end

    def subbed_kid_workshop_params
      if params[:subscription][:subbed_kid_workshop].present?
        params[:subscription][:subbed_kid_workshop][:option] = params[:subscription][:subbed_kid_workshop][:option].to_i
      end
      params[:subscription].require(:subbed_kid_workshop).permit(:sub_id, :kid_workshop_slot_id, :option, :comment)
    end

    def course_params
      if params[:subscription][:course].present?
        params[:subscription][:course][:option] = params[:subscription][:course][:option].to_i
      end
      params[:subscription].require(:course).permit(:instrument_id, :slot_id, :option, :comment)
    end

    def subbed_workshop_params
      if params[:subscription][:subbed_workshop].present?
        params[:subscription][:subbed_workshop][:option] = params[:subscription][:subbed_workshop][:option].to_i
      end
      params[:subscription].require(:subbed_workshop).permit(:workshop_slot_id, :option, :comment)
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
      @filters = {}
      @filters[:subscription_group] = {}
      @filters[:subscription_group][:status] = params[:status] if params[:status].present?
      @filters[:subbed_kid_workshops] = SubbedKidWorkshop.includes(:kid_workshop_slot).where(kid_workshop_slot: { kid_workshop: params[:kid_workshop] }) if params[:kid_workshop].present?
      @filters[:courses] = Course.where(instrument: params[:instrument]) if params[:instrument].present?
      @filters[:subbed_workshops] = SubbedWorkshop.includes(:workshop_slot).where(workshop_slot: { workshop: params[:workshop] }) if params[:workshop].present?

      if !@filters.empty?
        @filters[:subscription_group][:season] = @season
        @filtered_subscriptions = Subscription.includes(:subscription_group).where(@filters)
      else
        @filtered_subscriptions = Subscription.includes(:subscription_group).where(subscription_group: { season: @season })
      end

      @not_filters = {}
      @not_filters[:subscription_group] = { status: params[:exclude_status] } if params[:exclude_status].present?

      if !@not_filters.empty?
        @filtered_subscriptions = @filtered_subscriptions.where.not(@not_filters)
      end

      if query.present?
        @filtered_subscriptions = @filtered_subscriptions.where(student: Student.where("last_name ILIKE ?", "%#{query}%")).or(@filtered_subscriptions.where(student: Student.where("first_name ILIKE ?", "%#{query}%")))
      end

      @filtered_subscriptions = @filtered_subscriptions.where(student: Student.where("birth_year > ?", params[:birthyear_under])) if params[:birthyear_under].present?
      
      @filtered_subscriptions = @filtered_subscriptions.where(student: Student.where("birth_year < ?", params[:birthyear_over])) if params[:birthyear_over].present?

      @selected_emails = @filtered_subscriptions.map {|subscription| subscription.email}.uniq.join("\n")
      @pagy, @subscriptions = paginate_records(@filtered_subscriptions)
    end
    
    def default_sort_attribute
      SORT_ATTRIBUTES["subscriptions"].first
    end

    def with_sort_params(records)
      if @sort_attribute.present?
        records.includes(:student).merge(Student.order(last_name: @sort_direction))
      else
        records
      end
    end
  
    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES["subscriptions"].include?(attribute)
    end
end
