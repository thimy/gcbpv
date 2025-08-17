class StudentsController < SecretariatController
  include WithTableConcern

  before_action :authenticate_admin
  before_action :query
  before_action :set_student, only: %i[ show edit update destroy edit_personal_info show_personal_info ]
  before_action :set_subscription, only: %i[ show edit update destroy ]
  before_action :set_cities, only: %i[ index ]
  before_action :set_lists, only: %i[ index new create show edit update add_course add_workshop ]

  SORT_ATTRIBUTES = {
    "subscriptions" => [
      "created_at",
      "student",
      "birth_year",
      "city"
    ]
  }

  # GET /subscriptions or /subscriptions.json
  def index
    set_tab_data
    @total_subscriptions = Subscription.active(@season).not_on_hold
    @confirmed_count = Subscription.active(@season).registered(@season).size
    @unconfirmed_count = @total_subscriptions.size - @confirmed_count
  end

  # GET /subscriptions/1 or /subscriptions/1.json
  def show
    @new_course_url = new_course_path
    @new_kid_workshop_url = new_subbed_kid_workshop_path
    @new_workshop_url = new_subbed_workshop_path
    if @subscription.present?
      @subbed_workshops = @subscription.subbed_workshops.adults.ordered
      @subbed_kid_workshops = @subscription.subbed_workshops.youth.ordered
      @courses = @subscription.courses.ordered
    end
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

    existing_student = Student.find { |student|
      params[:student][:name] == student.name
    }
    new_params[:student] = existing_student || Student.new(student_params)

    existing_household = Household.find { |household|
      params[:household][:name] == household.name
    }
    @household = existing_household || Household.new(household_params)

    @subscription_group = SubscriptionGroup.joins(:household).find_by(household: existing_household, season: Config.first.season)

    if @subscription_group.present?
      new_params[:subscription_group_id] = @subscription_group.id
    else
      new_params[:subscription_group] = SubscriptionGroup.new(season: Config.first.season, household: @household, majoration_class: @household.agglo, status: "Inscrit")
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
          format.html { redirect_to subscription_url(@subscription), notice: "L’élève a bien été enregistré." }
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
      if @student.update(student_params)
        format.html { redirect_to season_student_url(id: @student.id, season_name: @season.name), notice: "L’élève a bien été modifié." }
        format.json { render :show, status: :ok, location: @student }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1 or /subscriptions/1.json
  def destroy
    @subscription.destroy!
    @student.destroy! if @student.subscriptions.size == 0

    respond_to do |format|
      format.html { redirect_to season_students_path(season_name: @season.name), notice: "L’élève a bien été supprimé." }
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

  def edit_personal_info
  end

  def show_personal_info
  end

  private

    def query
      params[:q]
    end

    def set_student
      @student = Student.find(params[:id] || params[:student_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.includes(:subscription_group).find_by(student: @student, subscription_group: {season: @season})
    end

    def set_cities
      @cities = Student.all.map { |student|
        student.city_or_household_city
      }.flatten.uniq.reject { |c| c.blank? }.sort
    end

    def student_params
      if params[:student].present?
        if params[:household_address] == "1"
          params[:student][:address] = nil
          params[:student][:postcode] = nil
          params[:student][:city] = nil
          params[:student][:phone] = nil
          params[:student][:email] = nil
        end
        params.require(:student).permit(:first_name, :last_name, :birth_year, :gender, :phone, :email, :comment, :address, :postcode, :city)
      end
    end

    def set_lists
      @students = Student.all
      @households = Household.all
      @instruments = Instrument.active
      @workshops = Workshop.adults.active
      @kid_workshops = KidWorkshop.active
    end

    def set_records
      @filters = {}
      @filters[:subscription_group] = {}
      @filters[:subscription_group][:season] = @season

      @filters[:subscription_group][:majoration_class] = params[:majoration_class] if params[:majoration_class].present?

      @course_filter = {}
      @course_filter[:instrument] = params[:instrument] if params[:instrument].present?
      @course_filter[:slot] = {}
      @course_filter[:slot][:teacher] = params[:teacher] if params[:teacher].present?
      @course_filter[:slot][:day_of_week] = params[:course_day] if params[:course_day].present?
      @course_filter[:slot][:city] = params[:course_city] if params[:course_city].present?
      @course_filter[:slot][:frequency] = params[:frequency] if params[:frequency].present?
      @filters[:courses] = Course.includes(:slot).where(@course_filter) if @course_filter[:slot].present? || @course_filter[:instrument].present?

      @workshop_filter = {}
      @workshop_filter[:workshop] = [params[:workshop], params[:kid_workshop]].compact if (params[:workshop].present? || params[:kid_workshop].present?)
      @workshop_filter[:day_of_week] = params[:workshop_day] if params[:workshop_day].present?
      
      @filters[:subbed_workshops] = SubbedWorkshop.includes(:workshop_slot).where(workshop_slot: @workshop_filter) if @workshop_filter.present?

      @filters[:status] = params[:status] if params[:status].present?
      @filters[:ars] = params[:ars] if params[:ars].present?
      @filters[:image_consent] = params[:image_consent] if params[:image_consent].present?

      @not_filters = {}
      @not_filters[:subscription_group] = { status: [3] }
      @not_filters[:subscription_group][:status].push(params[:exclude_status]) if params[:exclude_status].present?

      @filtered_subscriptions = Subscription.includes(:subscription_group).where(@filters).where.not(@not_filters).where(student: Student.where("last_name ILIKE :term OR first_name ILIKE :term OR :term IS NULL", { term: "%#{query}%" }))

      @filtered_subscriptions = @filtered_subscriptions.where(student: Student.where("birth_year > ?", params[:birthyear_under])) if params[:birthyear_under].present?
      
      @filtered_subscriptions = @filtered_subscriptions.where(student: Student.where("birth_year < ?", params[:birthyear_over])) if params[:birthyear_over].present?
      
      if params[:postcode].present?
        @filtered_subscriptions = @filtered_subscriptions.where(student: Student.where("postcode LIKE ?", "#{params[:postcode]}%")).or(@filtered_subscriptions.where(student: Student.where(postcode: nil), subscription_group: { household: Household.where("postcode LIKE ?", "#{params[:postcode]}%")}))
      end

      if params[:city].present?
        @filtered_subscriptions = @filtered_subscriptions.where(student: Student.where("city = ?", params[:city])).or(@filtered_subscriptions.where(student: Student.where(city: nil), subscription_group: { household: Household.where("city = ?", params[:city]) }))
      end

      @item_size = @filtered_subscriptions.size
      @selected_emails = @filtered_subscriptions.map {|subscription| subscription.email}.uniq.join("\n")
      @pagy, @subscriptions = paginate_records(@filtered_subscriptions)
    end
    
    def default_sort_attribute
      SORT_ATTRIBUTES["subscriptions"].first
    end

    def default_sort_direction
      "desc"
    end

    def with_sort_params(records)
      if @sort_attribute.present?
        if @sort_attribute == "student"
          records.includes(:student).merge(Student.order(last_name: @sort_direction))
        elsif @sort_attribute == "birth_year"
          records.includes(:student).merge(Student.order(birth_year: @sort_direction))
        else
          records.order(@sort_attribute => @sort_direction)
        end
      else
        records.order(:created_at => @sort_direction)
      end
    end
  
    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES["subscriptions"].include?(attribute)
    end
end
