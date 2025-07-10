class Users::HouseholdsController < BaseController
  before_action :set_household, only: %i[ show edit update destroy ]
  layout "account"

  SORT_ATTRIBUTES = ["last_name", "birth_year"]

  # GET /households/1 or /households/1.json
  def show
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
    existing_household = Household.find_by(first_name: household_params[:first_name], last_name: household_params[:last_name], email: [current_user.email, nil])
    if existing_household.present?
      @household = existing_household
      respond_to do |format|
        if @household.update(household_params)
          current_user.update!(household_id: @household.id)
          format.html { redirect_to account_subscriptions_path, notice: "Vos informations ont bien été enregistrées." }
          format.json { render :show, status: :ok, location: @household }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @household.errors, status: :unprocessable_entity }
        end
      end
    else
      @household = Household.new(household_params)
      respond_to do |format|
        if @household.save
          current_user.update!(household_id: @household.id)
          format.html { redirect_to account_subscriptions_path, notice: "Vos informations ont bien été enregistrées." }
          format.json { render :show, status: :created, location: @household }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @household.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /households/1 or /households/1.json
  def update
    respond_to do |format|
      if @household.update(household_params)
        format.html { redirect_to user_household_url(@household), notice: "Household was successfully updated." }
        format.json { render :show, status: :ok, location: @household }
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
      format.html { redirect_to user_households_url, notice: "Household was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_household
      @household = Household.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def household_params
      params.require(:household).permit(:last_name, :first_name, :email, :phone, :address, :postcode, :city)
    end
end
