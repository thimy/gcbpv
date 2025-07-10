class UsersController < BaseController
  layout "account"

  before_action :authenticate_user!
  before_action :set_season
  before_action :set_household
  before_action :set_subscriptions
  before_action :redirect_account, only: %i[ index show ]

  def index
    redirect_to account_subscriptions_path
  end

  def validation
  end

  private

  def set_season
    @season = Config.first.season
  end

  def set_household
    @household = current_user.household_id.present? ? Household.find(current_user&.household_id) : nil
  end

  def set_subscriptions
    @subscription_group = SubscriptionGroup.active(@season).where(household: @household)
  end

  def redirect_account
    if @household.nil?
      redirect_to new_account_household_path
    elsif @subscription_group.nil?
      redirect_to account_subscriptions_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, household_attributes: [:last_name, :first_name, :email, :phone, :address, :postcode, :city])
  end
end
