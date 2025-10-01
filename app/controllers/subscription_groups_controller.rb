class SubscriptionGroupsController < BaseController
  before_action :set_subscription_group

  def edit_discount
    render "subscription_groups/edit_discount"
  end

  def edit_donation
  end

  def show_summary
  end

  def show_info
  end

  def edit_subscription_group
  end

  # PATCH/PUT /subscription_groups/1 or /subscription_groups/1.json
  def update
    respond_to do |format|
      if @subscription_group.update(subscription_group_params)
        format.html { redirect_to subscription_group_url(@subscription_group), notice: "L’inscription a bien été enregistrée." }
        format.json { render :show, status: :ok, location: @subscription_group }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subscription_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscription_groups/1 or /subscription_groups/1.json
  def destroy
    @subscription_group.destroy!
    @household.destroy! if @household.subscription_groups.size == 0

    respond_to do |format|
      format.html { redirect_to season_students_path(season_name: @season.name), notice: "L’inscription du foyer a bien été supprimée." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription_group
      @subscription_group = SubscriptionGroup.find(params[:id] || params[:subscription_group_id])
      @household = @subscription_group.household
    end

    # Only allow a list of trusted parameters through.
    def subscription_group_params
      params.require(:subscription_group).permit(:discount, :donation, :comment, :majoration_class)
    end
end
