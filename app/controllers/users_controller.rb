class UsersController < BaseController
  layout "account"

  before_action :authenticate_user!
  before_action :set_season
  before_action :set_payor
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

  def set_payor
    @payor = current_user.payor_id.present? ? Payor.find(current_user&.payor_id) : nil
  end

  def set_subscriptions
    @subscription_group = SubscriptionGroup.active(@season).where(payor: @payor)
  end

  def redirect_account
    if @payor.nil?
      redirect_to new_account_payor_path
    elsif @subscription_group.nil?
      redirect_to account_subscriptions_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, payor_attributes: [:last_name, :first_name, :email, :phone, :address, :postcode, :city])
  end
end
