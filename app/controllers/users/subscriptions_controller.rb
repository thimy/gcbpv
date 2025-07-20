class Users::SubscriptionsController < BaseController
  layout "account"

  before_action :set_subscription, only: %i[ show edit update destroy ]
  before_action :set_lists

  attr_reader :hide_private

  def index
    @subscription_group = @household.subscription_groups.find_by(season: @season)
    @membership = @season.plan.membership_price

    @group_on_hold = @subscription_group&.status == "Dans le panier"
    
    if @subscription_group.present?
      @subscriptions = Subscription.where(subscription_group: @subscription_group)
      @form_data = {
        "update-price-total-value": @subscription_group.total_cost
      }
      @form_data["controller"] = "update-price" if @subscription_group.status == "ON_HOLD"
    end
  end

  # GET /subscriptions/1 or /subscriptions/1.json
  def show
    @is_account = true

    @new_course_url = new_account_course_path
    @new_kid_workshop_url = new_account_subbed_kid_workshop_path
    @new_workshop_url = new_account_subbed_workshop_path

    @course_url = account_course_path
    @kid_workshop_url = account_subbed_kid_workshop_path
    @workshop_url = account_subbed_workshop_path
    
    @edit_course_url = edit_account_course_path
    @edit_kid_workshop_url = edit_account_subbed_kid_workshop_path
    @edit_workshop_url = edit_account_subbed_workshop_path

    @hide_private = true
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

    if params[:is_household]
      if @household.student.present?
        new_params[:student] = Student.find(@household.student)
      else
        if student_params.present?
          new_params[:student] = Student.new(student_params)
        else
          new_params[:student_id] = Student.find_by(first_name: student_params[:first_name], last_name: student_params[:last_name]).id
        end
      end
    end

    @subscription_group = @household.subscription_groups.find { |group| group.season == @season }
    if @subscription_group.present?
      new_params[:subscription_group_id] = @subscription_group.id
    else
      new_params[:subscription_group] = SubscriptionGroup.new(season: @season, household: @household, majoration_class: SubscriptionGroup.majoration_classes[@household.agglo], status: 3)
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
          current_user.update!(student_id: @subscription.student.id) if params[:is_household]
          format.html { redirect_to account_subscriptions_url, notice: "L’inscription a bien été enregistrée." }
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
        subbed_kid_workshop = SubbedWorkshop.new(subbed_kid_workshop_params.merge({subscription_id: params[:id]}))
        if subbed_kid_workshop.save
          format.html { redirect_to account_subscription_url(@subscription), notice: "L’atelier enfant a bien été ajouté." }
          format.json { render :show, status: :created, location: @subscription }
        end
      end
      if params[:add_course]
        course = Course.new(course_params.merge({subscription_id: params[:id]}))
        if course.save
          format.html { redirect_to account_subscription_url(@subscription), notice: "Le cours a bien été ajouté." }
          format.json { render :show, status: :created, location: @subscription }
        end
      end
      if params[:add_workshop]
        subbed_workshop = SubbedWorkshop.new(subbed_workshop_params.merge({subscription_id: params[:id]}))
        if subbed_workshop.save
          format.html { redirect_to account_subscription_url(@subscription), notice: "L’atelier a bien été ajouté." }
          format.json { render :show, status: :created, location: @subscription }
        end
      end
      if @subscription.update(subscription_params)
        format.html { redirect_to account_subscription_url(@subscription), notice: "L’inscription a bien été modifiée." }
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
      format.html { redirect_to users_subscriptions_url, notice: "L’inscription a bien été supprimée." }
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
    def set_lists
      @household = Household.find(current_user.household_id)
      @instruments = Instrument.active
      @workshops = Workshop.active
      @kid_workshops = KidWorkshop.active
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      if params[:household_address] == "yes"
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
      if params[:subscription][:student_attributes].present?
        if params[:subscription][:student_attributes][:name].present?
          name_params = params[:subscription][:student_attributes][:name].split(/ /, 2)
          params[:subscription][:student_attributes][:first_name] = name_params.first
          params[:subscription][:student_attributes][:last_name] = name_params.last
          params[:subscription][:student_attributes].delete(:name)
        else
          if params[:is_household] && @household.student.nil?
            params[:subscription][:student_attributes][:first_name] = @household.first_name
            params[:subscription][:student_attributes][:last_name] = @household.last_name
            params[:subscription][:student_attributes][:address] = @household.address
            params[:subscription][:student_attributes][:postcode] = @household.postcode
            params[:subscription][:student_attributes][:city] = @household.city
            params[:subscription][:student_attributes][:email] = @household.email
          end
          params[:subscription][:student_attributes][:birth_year] = params[:subscription][:student_attributes][:birth_year].to_i
        end
      end
      params.require(:student).permit(:first_name, :last_name, :birth_year, :gender, :phone, :email, :comment, :address, :postcode, :city)
    end
end
