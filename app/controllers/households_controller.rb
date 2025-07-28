class HouseholdsController < SecretariatController
  include WithTableConcern

  before_action :authenticate_admin
  before_action :set_household, only: %i[ show edit update destroy edit_personal_info show_personal_info ]

  SORT_ATTRIBUTES = ["last_name", "birth_year"]

  # GET /households or /households.json
  def index
    set_tab_data
  end

  # GET /households/1 or /households/1.json
  def show
    @subscription_group = @household.subscription_group(@season)
    @subscriptions = @subscription_group&.subscriptions
  end

  # GET /households/new
  def new
    @household = Household.new
  end

  # GET /households/1/edit
  def edit
  end

  # POST /households or /households.json
  def create
    @household = Household.new(household_params)

    respond_to do |format|
      if @household.save
        format.html { redirect_to household_url(@household), notice: "Household was successfully created." }
        format.json { render :show, status: :created, location: @household }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @household.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /households/1 or /households/1.json
  def update
    respond_to do |format|
      if @household.update(household_params)
        format.html { redirect_to household_url(@household), notice: "household was successfully updated." }
        format.json { render :show, status: :ok, location: @household }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @household.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /households/1 or /households/1.json
  def destroy
    @household.destroy!

    respond_to do |format|
      format.html { redirect_to households_url, notice: "household was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def edit_personal_info
  end

  def show_personal_info
  end

  private
    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_household
      @household = Household.find(params[:id] || params[:household_id])
    end

    # Only allow a list of trusted parameters through.
    def household_params
      params.require(:household).permit(:last_name, :first_name, :email, :secondary_email, :phone, :secondary_phone, :address, :postcode, :city, :comment)
    end

    def set_records
      @subscription_groups = SubscriptionGroup.where(status: params[:status]) if params[:status].present?

      if !@subscription_groups.nil?
        @filtered_households = Household.includes(:subscription_groups).where(subscription_groups: @subscription_groups)
      else
        @filtered_households = Household.includes(:subscription_groups).where(subscription_groups: { season: @season })
      end

      if query.present?
        @filtered_households = @filtered_households.where("last_name ILIKE ?", "%#{query}%").or(@filtered_households.where("first_name ILIKE ?", "%#{query}%"))
      end

      @selected_emails = @filtered_households.map {|household| household.household_email}.uniq.join("\n")
      @pagy, @households = paginate_records(@filtered_households)
    end

    def default_sort_attribute
      SORT_ATTRIBUTES.first
    end
  
    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES.include?(attribute)
    end
end
