class SubscriptionsController < SecretariatController
  layout "secretariat"
  include WithTableConcern

  before_action :query
  before_action :set_subscription, only: %i[ show edit update destroy edit_subscription show_subscription ]
  before_action :set_cities, only: %i[ index edit update ]
  before_action :set_lists, only: %i[ index new create show edit update add_course add_workshop ]

  SORT_ATTRIBUTES = {
    "subscriptions" => [
      "student",
      "birth_year",
      "city"
    ]
  }

  # GET /subscriptions or /subscriptions.json
  def index
    set_tab_data
    @seasons = Season.all.reverse.map {|season| season.name}
    @total_subscriptions = Subscription.active(@season).not_on_hold
    @confirmed_count = Subscription.active(@season).registered(@season).size
    @unconfirmed_count = @total_subscriptions.size - @confirmed_count
  end

  # GET /subscriptions/1 or /subscriptions/1.json
  def show
    @new_course_url = new_course_path
    @new_kid_workshop_url = new_subbed_kid_workshop_path
    @new_workshop_url = new_subbed_workshop_path
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

    build_student

    existing_student = Student.find { |student|
      params[:student][:name] == student.name || [params[:student][:first_name], params[:student][:last_name]].join(" ") == student.name
    }
    new_params[:student] = existing_student || Student.new(student_params)

    existing_payor = Payor.find { |payor|
      params[:payor][:name] == payor.name
    }
    @payor = existing_payor || Payor.new(payor_params)

    @subscription_group = SubscriptionGroup.joins(:payor).find_by(payor: existing_payor, season: Config.first.season)

    if @subscription_group.present?
      new_params[:subscription_group_id] = @subscription_group.id
    else
      new_params[:subscription_group] = SubscriptionGroup.new(season: Config.first.season, payor: @payor, majoration_class: @payor.agglo, status: "Inscrit")
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
          format.html { redirect_to season_students_url(@season.name), notice: "L’inscription a bien été enregistrée." }
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
          format.html { redirect_to season_student_url(student: @subscription.student, season_name: @season.name), notice: "L’atelier enfant a bien été ajouté." }
          format.json { render :show, status: :created, location: @subscription }
        end
      end
      if params[:add_course]
        course = Course.new(course_params.merge({subscription_id: params[:id]}))
        if course.save
          format.html { redirect_to season_student_url(student: @subscription.student, season_name: @season.name), notice: "Le cours a bien été ajouté." }
          format.json { render :show, status: :created, location: @subscription }
        end
      end
      if params[:add_workshop]
        subbed_workshop = SubbedWorkshop.new(subbed_workshop_params.merge({subscription_id: params[:id]}))
        if subbed_workshop.save
          format.html { redirect_to season_student_url(student: @subscription.student, season_name: @season.name), notice: "L’atelier a bien été ajouté." }
          format.json { render :show, status: :created, location: @subscription }
        end
      end
      if @subscription.update(subscription_params)
        format.html { redirect_to season_student_url(student: @subscription.student, season_name: @season.name), notice: "L’inscription a bien été modifiée." }
        format.json { render :show, status: :ok, location: @subscription }
        format.turbo_stream
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
      format.html { redirect_to season_students_path(@season), notice: "L’inscription a bien été supprimée." }
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

  def edit_subscription
  end

  def show_subscription
  end

  private

    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id] || params[:subscription_id])
      @subscription_group = @subscription.subscription_group
    end

    def set_cities
      @cities = Student.all.map { |student|
        student.city_or_payor_city
      }.flatten.uniq.reject { |c| c.blank? }.sort
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      if params[:payor_address] == "yes"
        params[:subscription][:student_attributes][:address] = nil
        params[:subscription][:student_attributes][:postcode] = nil
        params[:subscription][:student_attributes][:city] = nil
      end
      params.require(:subscription).permit(:student_id, :subscription_group_id, :ars, :disability, :image_consent, :comment, courses_attributes: [:instrument_id, :slot_id, :option, :comment], subbed_workshops_attributes: [:workshop_slot_id, :option, :comment], subbed_kid_workshops_attributes: [:kid_workshop_slot_id, :option, :comment], subbed_kid_workshop_attributes: [:kid_workshop_slot_id, :option, :comment], student_attributes: [:id, :first_name, :last_name, :phone, :email, :gender, :address, :postcode, :city, :birth_year, :comment])
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
        if params[:is_payor] == "1"
          payor = Payor.find { |payor|
            params[:payor][:name] == payor.name
          }

          if payor.present?
            params[:student][:first_name] = payor.first_name
            params[:student][:last_name] = payor.last_name
          else
            params[:student][:first_name] = payor_params[:first_name]
            params[:student][:last_name] = payor_params[:last_name]
          end
          if params[:student][:birth_year].present?
            params[:student][:birth_year] = params[:student][:birth_year].to_i
          end
        end
        params.require(:student).permit(:first_name, :last_name, :birth_year, :gender, :phone, :email, :comment, :address, :postcode, :city)
      end
    end

    def payor_params
      if params[:payor].present?
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
      @filters[:subscription_group][:season] = @season

      @filters[:subscription_group][:status] = params[:status] if params[:status].present?
      @filters[:subscription_group][:majoration_class] = params[:majoration_class] if params[:majoration_class].present?

      @filters[:subbed_kid_workshops] = SubbedKidWorkshop.includes(:kid_workshop_slot).where(kid_workshop_slot: { kid_workshop: params[:kid_workshop] }) if params[:kid_workshop].present?

      @course_filter = {}
      @course_filter[:instrument] = params[:instrument] if params[:instrument].present?
      @course_filter[:slot] = {}
      @course_filter[:slot][:teacher] = params[:teacher] if params[:teacher].present?
      @course_filter[:slot][:day_of_week] = params[:course_day] if params[:course_day].present?
      @course_filter[:slot][:frequency] = params[:frequency] if params[:frequency].present?
      @filters[:courses] = Course.includes(:slot).where(@course_filter) if @course_filter[:slot].present? || @course_filter[:instrument].present?

      @workshop_filter = {}
      @workshop_filter[:workshop] = params[:workshop] if params[:workshop].present?
      @workshop_filter[:day_of_week] = params[:workshop_day] if params[:workshop_day].present?
      @filters[:subbed_workshops] = SubbedWorkshop.includes(:workshop_slot).where(workshop_slot: @workshop_filter) if @workshop_filter.present?

      @filters[:ars] = params[:ars] if params[:ars].present?
      @filters[:image_consent] = params[:image_consent] if params[:image_consent].present?

      @not_filters = {}
      @not_filters[:subscription_group] = { status: [3] }
      @not_filters[:subscription_group][:status].concat(params[:exclude_status]) if params[:exclude_status].present?

      @filtered_subscriptions = Subscription.includes(:subscription_group).where(@filters).where.not(@not_filters).where(student: Student.where("last_name ILIKE :term OR first_name ILIKE :term OR :term IS NULL", { term: "%#{query}%" }))

      @filtered_subscriptions = @filtered_subscriptions.where(student: Student.where("birth_year > ?", params[:birthyear_under])) if params[:birthyear_under].present?
      
      @filtered_subscriptions = @filtered_subscriptions.where(student: Student.where("birth_year < ?", params[:birthyear_over])) if params[:birthyear_over].present?
      
      if params[:postcode].present?
        @filtered_subscriptions = @filtered_subscriptions.where(student: Student.where("postcode LIKE ?", "#{params[:postcode]}%")).or(@filtered_subscriptions.where(student: Student.where(postcode: nil), subscription_group: { payor: Payor.where("postcode LIKE ?", "#{params[:postcode]}%")}))
      end

      if params[:city].present?
        @filtered_subscriptions = @filtered_subscriptions.where(student: Student.where("city = ?", params[:city])).or(@filtered_subscriptions.where(student: Student.where(city: nil), subscription_group: { payor: Payor.where("city = ?", params[:city]) }))
      end

      @item_size = @filtered_subscriptions.size
      @selected_emails = @filtered_subscriptions.map {|subscription| subscription.email}.uniq.join("\n")
      @pagy, @subscriptions = paginate_records(@filtered_subscriptions)
    end
    
    def default_sort_attribute
      SORT_ATTRIBUTES["subscriptions"].first
    end

    def with_sort_params(records)
      if @sort_attribute.present?
        if @sort_attribute == "student"
          records.includes(:student).merge(Student.order(last_name: @sort_direction))
        elsif @sort_attribute == "birth_year"
          records.includes(:student).merge(Student.order(birth_year: @sort_direction))
        end
      else
        records
      end
    end
  
    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES["subscriptions"].include?(attribute)
    end

    def build_student
      if params[:is_payor] == "1"
        payor = Payor.find { |payor|
          params[:payor][:name] == payor.name
        }

        if payor.present?
          params[:student][:first_name] = payor.first_name
          params[:student][:last_name] = payor.last_name
        else
          params[:student][:first_name] = payor_params[:first_name]
          params[:student][:last_name] = payor_params[:last_name]
        end
        if params[:student][:birth_year].present?
          params[:student][:birth_year] = params[:student][:birth_year].to_i
        end
      end
    end
end
