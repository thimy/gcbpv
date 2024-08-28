class Secretariat::InstrumentsController < SecretariatController
  before_action :set_instrument, only: %i[ show edit update destroy get_teachers ]

  # GET /instruments or /instruments.json
  def index
    @instrument_optionss = Instrument.where("name ILIKE ?", "%#{params[:q]}%").map{|instrument|
      {
        value: instrument.id,
        text: instrument.name
      }
    }
    @instruments = Instrument.all

    respond_to do |format|
      format.json
      format.html
    end
  end

  # GET /instruments/1 or /instruments/1.json
  def show
  end

  # GET /instruments/new
  def new
    @instrument = Instrument.new
  end

  # GET /instruments/1/edit
  def edit
  end

  # POST /instruments or /instruments.json
  def create
    @instrument = Instrument.new(instrument_params)

    respond_to do |format|
      if @instrument.save
        format.html { redirect_to instrument_url(@instrument), notice: "Instrument was successfully created." }
        format.json { render :show, status: :created, location: @instrument }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instruments/1 or /instruments/1.json
  def update
    respond_to do |format|
      if @instrument.update(instrument_params)
        format.html { redirect_to instrument_url(@instrument), notice: "Instrument was successfully updated." }
        format.json { render :show, status: :ok, location: @instrument }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instruments/1 or /instruments/1.json
  def destroy
    @instrument.destroy!

    respond_to do |format|
      format.html { redirect_to instruments_url, notice: "Instrument was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def get_teachers
    @teachers = Teacher.where(specialties: Specialty.where(instrument: @instrument))
    render json: @teachers.as_json(only: [:first_name, :last_name, :id]), status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instrument
      @instrument = Instrument.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def instrument_params
      params.require(:instrument).permit(:name, :description)
    end
end
