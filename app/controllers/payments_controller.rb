class PaymentsController < SecretariatController
  before_action :set_payment, only: %i[ show edit update destroy ]

  def show
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          @payment,
          partial: "payments/payment", 
          locals: {
            payment: @payment,
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
          "add-payment",
          partial: "payments/payment", 
          locals: {
            payment: Payment.new,
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
          @payment,
          partial: "payments/payment", 
          locals: {
            payment: @payment,
            is_form: true
          }
        )
      end
    end
  end

  def create
    @payment = Payment.new(payment_params)
    respond_to do |format|
      if @payment.save
        format.html { redirect_to secretariat_payment_url(@payment), notice: "Le paiement a bien été enregistré." }
        format.json { render :show, status: :created, location: @payment }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "new_payment",
            partial: "payments/payment", 
            locals: {
              payment: @payment,
              is_form: false
            }
          )
        }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_back fallback_location: household_url(@payment.subscription_group.household), notice: "Le paiement a bien été modifié." }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @household_id = @payment.subscription_group.household_id
    @payment.destroy!

    respond_to do |format|
      format.html { redirect_to household_url(@household_id), notice: "Le paiement a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      if params[:payment].present? && params[:payment][:id].present?
        params[:id] = params[:payment][:id]
        params[:payment].delete(:id)
        params[:payment].delete(:payment_id)

        params[:payment][:amount] = 0 if params[:payment][:amount].blank?
      end
      @payment = Payment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:payment_method, :amount, :comment, :subscription_group_id)
    end
end
