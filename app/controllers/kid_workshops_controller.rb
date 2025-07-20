class KidWorkshopsController < SecretariatController
  before_action :set_kid_workshop, only: %i[ show edit update destroy get_slots ]

  # GET /kid_workshops or /kid_workshops.json
  def index
    @workshops = KidWorkshop.active
  end

  # GET /kid_workshops/1 or /kid_workshops/1.json
  def show
    @confirmed_count = @workshop.subscriptions.registered(@season).confirmed.has_workshop(@workshop).size if @workshop.present?
    @optional_count = @workshop.subscriptions.registered(@season).optional.has_workshop(@workshop).size + @workshop.subscriptions.inquired(@season).has_workshop(@workshop).size if @workshop.present?
  end

  # GET /kid_workshops/new
  def new
    @cities = City.active
    @workshop = KidWorkshop.new
  end

  # GET /kid_workshops/1/edit
  def edit
  end

  # POST /kid_workshops or /kid_workshops.json
  def create
    @workshop = KidWorkshop.new(kid_workshop_params)

    respond_to do |format|
      if @workshop.save
        format.html { redirect_to kid_workshop_url(@workshop), notice: "Workshop was successfully created." }
        format.json { render :show, status: :created, location: @workshop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kid_workshops/1 or /kid_workshops/1.json
  def update
    respond_to do |format|
      if @workshop.update(kid_workshop_params)
        format.html { redirect_to kid_workshop_url(@workshop), notice: "L’atelier Enfance a bien été modifié." }
        format.json { render :show, status: :ok, location: @workshop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kid_workshops/1 or /kid_workshops/1.json
  def destroy
    @workshop.destroy!

    respond_to do |format|
      format.html { redirect_to kid_workshops_url, notice: "L’atelier Enfance a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  def get_slots
    @slots = KidWorkshopSlot.where(kid_workshop: @workshop)

    render json: @slots.as_json(only: [:id, :slot_time, :day_of_week], include: { city: { only: :name }}), status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kid_workshop
      @workshop = KidWorkshop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def kid_workshop_params
      params.require(:kid_workshop).permit(:name, :description, :workshop_type, :status, :comment)
    end
end
