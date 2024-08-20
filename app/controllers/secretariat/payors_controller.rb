class Secretariat::PayorsController < SecretariatController
  before_action :set_payor, only: %i[ show edit update destroy ]

  # GET /payors or /payors.json
  def index
    @payors = Payor.all
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
        format.html { redirect_to payor_url(@payor), notice: "Payor was successfully created." }
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
        format.html { redirect_to payor_url(@payor), notice: "Payor was successfully updated." }
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
      format.html { redirect_to payors_url, notice: "Payor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payor
      @payor = Payor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payor_params
      params.require(:payor).permit(:last_name, :first_name, :email, :phone)
    end
end
