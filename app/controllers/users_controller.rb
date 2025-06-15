class UsersController < BaseController
  layout "account"

  before_action :authenticate_user!
  before_action :set_season
  before_action :set_payor
  before_action :require_payor

  def index
  end

  private

  def set_season
    @season = Config.first.season
  end

  def set_payor
    @payor = current_user.payor_id.present? ? Payor.find(current_user.payor_id) : nil
  end

  def set_members
    @members = Student.where(payor: @payor)
  end

  def require_payor
    if @payor.nil?
      redirect_to new_account_payor_path
    elsif @members.nil?
      redirect_to account_subscriptions_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, payor_attributes: [:last_name, :first_name, :email, :phone, :address, :postcode, :city])
  end
end
