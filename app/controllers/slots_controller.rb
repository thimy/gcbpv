class SlotsController < SecretariatController
  before_action :authenticate_admin
  before_action :set_slot, only: %i[ show edit update destroy ]

  # GET /slots or /slots.json
  def index
    @slots = Slot.all
  end

  # GET /slots/1 or /slots/1.json
  def show
  end

  # GET /slots/new
  def new
    @slot = Slot.new
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.before(
          "add-slot",
          partial: "slots/slot", 
          locals: {
            slot: Slot.new,
            cities: City.all,
            is_form: true
          }
        )
      end
    end
  end

  # GET /slots/1/edit
  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          @slot,
          partial: "slots/slot", 
          locals: {
            slot: @slot,
            cities: City.all,
            is_form: true
          }
        )
      end
    end
  end

  # POST /slots or /slots.json
  def create
    @slot = Slot.new(slot_params)

    respond_to do |format|
      if @slot.save
        format.html { redirect_to slot_url(@slot), notice: "Slot was successfully created." }
        format.json { render :show, status: :created, location: @slot }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "new_slot",
            partial: "slots/slot", 
            locals: {
              slot: @slot,
              is_form: false
            }
          )
        }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slots/1 or /slots/1.json
  def update
    respond_to do |format|
      if @slot.update(slot_params)
        format.html { redirect_to secretariat_slot_url(@slot), notice: "Le créneau a bien été modifié." }
        format.json { render :show, status: :ok, location: @slot }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slots/1 or /slots/1.json
  def destroy
    @slot.destroy!

    respond_to do |format|
      format.html { redirect_to slots_url, notice: "Slot was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slot
      if params[:slot].present? && params[:slot][:id].present?
        params[:id] = params[:slot][:id]
        params[:slot].delete(:id)
      end
      @slot = Slot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def slot_params
      params.require(:slot).permit(:slot_id, :city_id, :day_of_week, :slot_time, :frequency, :teacher_id)
    end
end
