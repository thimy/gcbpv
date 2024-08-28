class Secretariat::KidWorkshopsController < SecretariatController
  before_action :set_kid_workshop, only: %i[ show edit update destroy get_slots ]

  # GET /kid_workshops or /kid_workshops.json
  def index
    @kid_workshops = KidWorkshop.active
  end

  # GET /kid_workshops/1 or /kid_workshops/1.json
  def show
    @confirmed_count = @kid_workshop.subscriptions.registered.confirmed.has_workshop(@kid_workshop).size
    @optional_count = @kid_workshop.subscriptions.registered.optional.has_workshop(@kid_workshop).size + @kid_workshop.subscriptions.inquired.has_workshop(@kid_workshop).size
  end

  # GET /kid_workshops/new
  def new
    @kid_workshop = KidWorkshop.new
  end

  # GET /kid_workshops/1/edit
  def edit
  end

  # POST /kid_workshops or /kid_workshops.json
  def create
    @kid_workshop = KidWorkshop.new(kid_workshop_params)

    respond_to do |format|
      if @kid_workshop.save
        format.html { redirect_to workshop_url(@kid_workshop), notice: "Workshop was successfully created." }
        format.json { render :show, status: :created, location: @kid_workshop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @kid_workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kid_workshops/1 or /kid_workshops/1.json
  def update
    respond_to do |format|
      if @kid_workshop.update(kid_workshop_params)
        format.html { redirect_to secretariat_kid_workshop_url(@kid_workshop), notice: "L’atelier Enfance a bien été modifié." }
        format.json { render :show, status: :ok, location: @kid_workshop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @kid_workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kid_workshops/1 or /kid_workshops/1.json
  def destroy
    @kid_workshop.destroy!

    respond_to do |format|
      format.html { redirect_to secretariat_kid_workshops_url, notice: "L’atelier Enfance a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  def get_slots
    @slots = KidWorkshopSlot.where(kid_workshop: @kid_workshop)

    render json: @slots.as_json(only: [:id, :slot_time, :day_of_week], include: { city: { only: :name }}), status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kid_workshop
      @kid_workshop = KidWorkshop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def kid_workshop_params
      params.require(:kid_workshop).permit(:name, :description, :city_id, :day_of_week, :frequency, :start_time, :end_time)
    end
end
