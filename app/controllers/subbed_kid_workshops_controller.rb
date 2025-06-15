class SubbedKidWorkshopsController < SecretariatController
  before_action :set_subbed_kid_workshop, only: %i[ show edit update destroy ]

  def show
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          @subbed_kid_workshop,
          partial: "subbed_kid_workshops/subbed_kid_workshop", 
          locals: {
            subbed_kid_workshop: @subbed_kid_workshop,
            is_form: false
          }
        )
      end
    end
  end

  def new
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.before(
          "add-kid-workshop",
          partial: "subbed_kid_workshops/subbed_kid_workshop", 
          locals: {
            subbed_kid_workshop: SubbedKidWorkshop.new,
            kid_workshops: KidWorkshop.active,
            kid_workshop_slots: [],
            is_form: true
          }
        )
      end
    end    
  end

  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          @subbed_kid_workshop,
          partial: "subbed_kid_workshops/subbed_kid_workshop", 
          locals: {
            subbed_kid_workshop: @subbed_kid_workshop,
            kid_workshops: KidWorkshop.active,
            kid_workshop_slots: KidWorkshopSlot.where(kid_workshop: @subbed_kid_workshop.kid_workshop_slot.kid_workshop_id),
            is_form: true
          }
        )
      end
    end
  end

  def create
    @subbed_kid_workshop = SubbedKidWorkshop.new(subbed_kid_workshop_params)

    respond_to do |format|
      if @subbed_kid_workshop.save
        format.html { redirect_to secretariat_subbed_kid_workshop_url(@subbed_kid_workshop), notice: "L’atelier a bien été enregistré." }
        format.json { render :show, status: :created, location: @subbed_kid_workshop }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "new_subbed_kid_workshop",
            partial: "subbed_kid_workshops/subbed_kid_workshop", 
            locals: {
              subbed_kid_workshop: @subbed_kid_workshop,
              is_form: false
            }
          )
        }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subbed_kid_workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subbed_kid_workshops/1 or /subbed_kid_workshops/1.json
  def update
    respond_to do |format|
      if @subbed_kid_workshop.update(subbed_kid_workshop_params)
        format.html { redirect_back fallback_location: secretariat_subscription_url(@subbed_kid_workshop.subscription_id), notice: "L’atelier a bien été modifié." }
        format.json { render :show, status: :ok, location: @subbed_kid_workshop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subbed_kid_workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subbed_kid_workshops/1 or /subbed_kid_workshops/1.json
  def destroy
    @subscription_id = @subbed_kid_workshop.subscription_id
    @subbed_kid_workshop.destroy!

    respond_to do |format|
      format.html { redirect_to secretariat_subscription_url(@subscription_id), notice: "L’atelier a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subbed_kid_workshop
      if params[:subbed_kid_workshop].present? && params[:subbed_kid_workshop][:id].present?
        params[:id] = params[:subbed_kid_workshop][:id]
        params[:subbed_kid_workshop].delete(:id)
        params[:subbed_kid_workshop].delete(:kid_workshop_id)
      end
      @subbed_kid_workshop = SubbedKidWorkshop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subbed_kid_workshop_params
      params.require(:subbed_kid_workshop).permit(:kid_workshop_slot_id, :option, :comment, :subscription_id)
    end
end
