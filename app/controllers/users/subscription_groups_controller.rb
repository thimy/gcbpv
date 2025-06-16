class Users::SubscriptionGroupsController < BaseController
  layout "account"

  before_action :set_subscription_group, only: %i[ update ]

  # PATCH/PUT /subscriptions/1 or /subscriptions/1.json
  def update
    params[:subscription_group][:status] = "REGISTERED"
    respond_to do |format|
      if @subscription_group.update(subscription_group_params)
        @subscription_group.send_subscription_confirmation(current_user)
        format.html { redirect_to account_validation_url, notice: "L’inscription a bien été enregistrée." }
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
      @subscription_group = SubscriptionGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subscription_group_params
      params.require(:subscription_group).permit(:donation, :status)
    end
end
