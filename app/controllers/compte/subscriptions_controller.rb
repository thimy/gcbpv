class Compte::SubscriptionsController < CompteController
  before_action :set_subscription, only: %i[ show edit update destroy ]
  before_action :set_lists, only: %i[ new create edit add_course add_workshop ]

  # GET /subscriptions or /subscriptions.json
  def index
    @subscriptions = Subscription.where(payor: current_user)
  end

  # GET /subscriptions/1 or /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
    @subscription = Subscription.new
  end

  # POST /subscriptions or /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params.merge({id: params[:id]}))

    respond_to do |format|
      if params[:add_course]
        @subscription.courses.build
        format.html { render :new, status: :unprocessable_entity }
      elsif params[:add_workshop]
        @subscription.subbed_workshops.build
        format.html { render :new, status: :unprocessable_entity }
      else
        if @subscription.save
          format.html { redirect_to subscription_url(@subscription), notice: "L’inscription a été créée avec succès." }
          format.json { render :show, status: :created, location: @subscription }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @subscription.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def add_course
    @subscription = Subscription.new(subscription_params.merge({id: params[:id]}))
    @subscription.courses.build
    render :new
  end

  def add_workshop
    @subscription = Subscription.new(subscription_params.merge({id: params[:id]}))
    @subscription.subbed_workshops.build
    render :new
  end

  # PATCH/PUT /subscriptions/1 or /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to subscription_url(@subscription), notice: "L’inscription a été mise à jour avec succès." }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1 or /subscriptions/1.json
  def destroy
    @subscription.destroy!

    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: "L’inscription a été supprimée avec succès." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
      @subscription.season = Config.first.season
    end

    def set_lists
      @instruments = Instrument.all
      @teachers = Teacher.all
      @slots = Slot.all
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      params.require(:subscription).permit(
        :name,
        :description,
        :image_consent,
        :disability,
        :ars,
        :students_attributes => [:first_name, :last_name, :gender, :phone, :email],
        :courses_attributes => [:instrument_id, :teacher_id, :slot_id],
        :subbed_workshops_attributes => [:workshop_id, :comment])
    end
end

