class SubscriptionGroupsController < BaseController
  before_action :set_subscription_group

  def edit_discount
    render "subscription_groups/edit_discount"
  end

  def edit_donation
  end

  def show_summary
  end

  # PATCH/PUT /subscriptions/1 or /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription_group.update(subscription_group_params)
        format.turbo_stream
        format.html { redirect_to subscription_group_url(@subscription_group), notice: "L’inscription a bien été enregistrée." }
        format.json { render :show, status: :ok, location: @subscription_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subscription_group.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription_group
      @subscription_group = SubscriptionGroup.find(params[:id] || params[:subscription_group_id])
    end

    # Only allow a list of trusted parameters through.
    def subscription_group_params
      params.require(:subscription_group).permit(:discount, :donation)
    end
end
