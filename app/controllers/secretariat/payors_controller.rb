class Secretariat::PayorsController < SecretariatController
  include WithTableConcern

  before_action :set_payor, only: %i[ show edit update destroy ]

  SORT_ATTRIBUTES = ["last_name"]

  # GET /payors or /payors.json
  def index
    set_tab_data
  end

  # GET /payors/1 or /payors/1.json
  def show
  end

  # GET /payors/new
  def new
    @payor = Payor.new
  end

  # GET /payors/1/edit
  def edit
  end

  # POST /payors or /payors.json
  def create
    @payor = Payor.new(payor_params)

    respond_to do |format|
      if @payor.save
        format.html { redirect_to secretariat_payor_url(@payor), notice: "Payor was successfully created." }
        format.json { render :show, status: :created, location: @payor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payors/1 or /payors/1.json
  def update
    respond_to do |format|
      if @payor.update(payor_params)
        format.html { redirect_to secretariat_payor_url(@payor), notice: "Payor was successfully updated." }
        format.json { render :show, status: :ok, location: @payor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payors/1 or /payors/1.json
  def destroy
    @payor.destroy!

    respond_to do |format|
      format.html { redirect_to secretariat_payors_url, notice: "Payor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_payor
      @payor = Payor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payor_params
      params.require(:payor).permit(:last_name, :first_name, :email, :phone)
    end

    def set_records
      @subscription_groups = SubscriptionGroup.where(status: params[:status]) if params[:status].present?

      if !@subscription_groups.nil?
        @filtered_payors = Payor.includes(:subscription_groups).where(subscription_groups: @subscription_groups)
      else
        @filtered_payors = Payor.includes(:subscription_groups).where(subscription_groups: { season: @season })
      end

      if query.present?
        @filtered_payors = @filtered_payors.where("last_name ILIKE ?", "%#{query}%").or(@filtered_payors.where("first_name ILIKE ?", "%#{query}%"))
      end

      @selected_emails = @filtered_payors.map {|payor| payor.email}.uniq.join("\n")
      @pagy, @payors = paginate_records(@filtered_payors)
    end

    def default_sort_attribute
      SORT_ATTRIBUTES.first
    end
  
    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES.include?(attribute)
    end
end
