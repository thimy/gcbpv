class Secretariat::EmailsController < SecretariatController
  include WithTableConcern

  before_action :query
  before_action :set_email, only: %i[ show edit update destroy ]

  SORT_ATTRIBUTES = ["emails"]

  # GET /emails or /emails.json
  def index
    set_tab_data
  end

  # GET /emails/1 or /emails/1.json
  def show
  end

  # GET /emails/new
  def new
    @email = Email.new
  end

  # GET /emails/1/edit
  def edit
  end

  # POST /emails or /emails.json
  def create
    respond_to do |format|
      if params[:add_course]
        @email.courses.build
        format.html { render :new, status: :unprocessable_entity }
      elsif params[:add_workshop]
        @email.subbed_workshops.build
        format.html { render :new, status: :unprocessable_entity }
      else
        if @email.save
          format.html { redirect_to secretariat_email_url(@email), notice: "L’email a bien été enregistré." }
          format.json { render :show, status: :created, location: @email }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @email.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /emails/1 or /emails/1.json
  def update
    respond_to do |format|
      if @email.update(email_params)
        format.html { redirect_to secretariat_email_url(@email), notice: "L’email a bien été modifiée." }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1 or /emails/1.json
  def destroy
    @email.destroy!

    respond_to do |format|
      format.html { redirect_to secretariat_emails_url, notice: "L’email a bien été supprimée." }
      format.json { head :no_content }
    end
  end

  private

    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def email_params
      params.require(:email).permit(:subject, :recipients, :body)
    end

    def set_records
      @pagy, @emails = paginate_records(Email.all)
    end
    
    def default_sort_attribute
      SORT_ATTRIBUTES.first
    end

    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES.include?(attribute)
    end
end
