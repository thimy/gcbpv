class Users::PayorsController < BaseController
  before_action :set_payor, only: %i[ show edit update destroy ]
  layout "account"

  SORT_ATTRIBUTES = ["last_name", "birth_year"]

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
    existing_payor = Payor.find_by(first_name: payor_params[:first_name], last_name: payor_params[:last_name], email: [current_user.email, nil])
    if existing_payor.present?
      @payor = existing_payor
      respond_to do |format|
        if @payor.update(payor_params)
          current_user.update!(payor_id: @payor.id)
          format.html { redirect_to account_subscriptions_path, notice: "Vos informations ont bien été enregistrées." }
          format.json { render :show, status: :ok, location: @payor }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @payor.errors, status: :unprocessable_entity }
        end
      end
    else
      @payor = Payor.new(payor_params)
      respond_to do |format|
        if @payor.save
          current_user.update!(payor_id: @payor.id)
          format.html { redirect_to account_subscriptions_path, notice: "Vos informations ont bien été enregistrées." }
          format.json { render :show, status: :created, location: @payor }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @payor.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /payors/1 or /payors/1.json
  def update
    respond_to do |format|
      if @payor.update(payor_params)
        format.html { redirect_to user_payor_url(@payor), notice: "Payor was successfully updated." }
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
      format.html { redirect_to user_payors_url, notice: "Payor was successfully destroyed." }
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
      params.require(:payor).permit(:last_name, :first_name, :email, :phone, :address, :postcode, :city)
    end
end
