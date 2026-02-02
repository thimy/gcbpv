class WorkshopsController < SecretariatController
  before_action :authenticate_admin
  before_action :set_workshop, only: %i[ show edit update destroy get_slots ]

  # GET /workshops or /workshops.json
  def index
    @workshops = Workshop.active(@season).adults
  end

  # GET /workshops/1 or /workshops/1.json
  def show
    @confirmed_count = @workshop.subscriptions.registered(@season).confirmed.has_workshop(@workshop).size
    @optional_count = @workshop.subscriptions.registered(@season).optional.has_workshop(@workshop).size + @workshop.subscriptions.inquired(@season).has_workshop(@workshop).size
  end

  # GET /workshops/new
  def new
    @workshop = Workshop.new
  end

  # GET /workshops/1/edit
  def edit
  end

  # POST /workshops or /workshops.json
  def create
    @workshop = Workshop.new(workshop_params)

    respond_to do |format|
      if @workshop.save
        format.html { redirect_to workshop_url(@workshop), notice: "Workshop was successfully created." }
        format.json { render :show, status: :created, location: @workshop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workshops/1 or /workshops/1.json
  def update
    respond_to do |format|
      if @workshop.update(workshop_params)
        format.html { redirect_to workshop_url(@workshop), notice: "Workshop was successfully updated." }
        format.json { render :show, status: :ok, location: @workshop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workshops/1 or /workshops/1.json
  def destroy
    @workshop.destroy!

    respond_to do |format|
      format.html { redirect_to workshops_url, notice: "Workshop was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def get_slots
    @slots = WorkshopSlot.visible.where(workshop: @workshop)

    render json: @slots.as_json(only: [:id, :slot_time, :day_of_week], include: { city: { only: :name }}), status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workshop
      @workshop = Workshop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def workshop_params
      params.require(:workshop).permit(:name, :description, :status, :comment)
    end
end
