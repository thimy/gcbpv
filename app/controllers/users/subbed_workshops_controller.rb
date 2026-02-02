class Users::SubbedWorkshopsController < BaseController
  before_action :set_subbed_workshop, only: %i[ show edit update destroy ]
  before_action :set_hidden_fields, only: %i[ show new edit create ]

  def show
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          @subbed_workshop,
          partial: "subbed_workshops/subbed_workshop", 
          locals: {
            subbed_workshop: @subbed_workshop,
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
          "add-workshop",
          partial: "subbed_workshops/subbed_workshop", 
          locals: {
            subbed_workshop: SubbedWorkshop.new,
            workshops: Workshop.active(@season),
            workshop_slots: [],
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
          @subbed_workshop,
          partial: "subbed_workshops/subbed_workshop", 
          locals: {
            subbed_workshop: @subbed_workshop,
            workshops: Workshop.active(@season),
            workshop_slots: WorkshopSlot.where(workshop: @subbed_workshop.workshop_slot.workshop_id),
            is_form: true
          }
        )
      end
    end
  end

  def create
    @subbed_workshop = SubbedWorkshop.new(subbed_workshop_params)

    respond_to do |format|
      if @subbed_workshop.save
        format.html { redirect_to account_subbed_workshop_url(@subbed_workshop), notice: "L’atelier a bien été enregistré." }
        format.json { render :show, status: :created, location: @subbed_workshop }
        format.turbo_stream {
          puts "pouet"
          render turbo_stream: turbo_stream.replace(
            "new_subbed_workshop",
            partial: "subbed_workshops/subbed_workshop", 
            locals: {
              subbed_workshop: @subbed_workshop,
              is_form: false
            }
          )
        }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subbed_workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subbed_workshops/1 or /subbed_workshops/1.json
  def update
    respond_to do |format|
      if @subbed_workshop.update(subbed_workshop_params)
        format.html { redirect_back fallback_location: account_subscription_url(@subbed_workshop.subscription_id), notice: "L’atelier a bien été modifié." }
        format.json { render :show, status: :ok, location: @subbed_workshop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subbed_workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subbed_workshops/1 or /subbed_workshops/1.json
  def destroy
    @subscription_id = @subbed_workshop.subscription_id
    @subbed_workshop.destroy!

    respond_to do |format|
      format.html { redirect_to account_subscription_url(@subscription_id), notice: "L’atelier a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  private
    def set_hidden_fields
      @is_account = true
      @hide_private = true
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_subbed_workshop
      if params[:subbed_workshop].present? && params[:subbed_workshop][:id].present?
        params[:id] = params[:subbed_workshop][:id]
        params[:subbed_workshop].delete(:id)
        params[:subbed_workshop].delete(:workshop_id)
      end
      @subbed_workshop = SubbedWorkshop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subbed_workshop_params
      params.require(:subbed_workshop).permit(:workshop_slot_id, :option, :comment, :subscription_id)
    end
end
