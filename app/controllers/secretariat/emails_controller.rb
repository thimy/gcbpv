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
    @email = Email.new(email_params)

    respond_to do |format|
      if @email.save
        @email.save_email_images
        @email.save_attachments
        if params[:send_now]
          SubscriptionMailer.with(email: @email).standard_mail.deliver_later
        end
        format.html { redirect_to secretariat_email_url(@email), notice: "L’email a bien été enregistré." }
        format.json { render :show, status: :created, location: @email }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emails/1 or /emails/1.json
  def update
    respond_to do |format|
      if @email.update(email_params)
        @email.save_email_images
        @email.save_attachments
        format.html { redirect_to secretariat_email_url(@email), notice: "L’email a bien été modifié." }
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
      format.html { redirect_to secretariat_emails_url, notice: "L’email a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  def upload_image
    image = params[:image]

    if image.nil?
      render json: { success: 0, error: "Pas d’image dans cette requête" }
      return
    end

    uploaded_image = EmailImage.create!(image: image)
    stored_image_url = rails_blob_url(uploaded_image.image)

    render json: { success: 1, file: { url: stored_image_url } }
  rescue StandardError => e
    render json: { success: 0, error: e.message }
  end

  def upload_file
    file_params = {
      file: params[:file]
    }

    file_params[:name] = params[:file].original_filename if params[:file].original_filename.present?
    file_params[:extension] = Rack::Mime::MIME_TYPES.invert[params[:file].content_type].sub(".", "") if params[:file].content_type.present?
    file_params[:size] = params[:file].size if params[:file].size.present?

    if file_params[:file].nil?
      render json: { success: 0, error: "Pas de fichier dans cette requête" }
      return
    end

    uploaded_file = Attachment.create!(file_params)
    stored_file_url = rails_blob_url(uploaded_file.file)

    response_params = {
      url: stored_file_url
    }
    response_params[:name] = uploaded_file.name if uploaded_file.name.present?
    response_params[:extension] = uploaded_file.extension if uploaded_file.extension.present?
    response_params[:size] = uploaded_file.size if uploaded_file.size.present?

    render json: { success: 1, file: response_params }
  rescue StandardError => e
    render json: { success: 0, error: e.message }
  end

  def send_email
    @email = Email.find(params[:email_id])
    SubscriptionMailer.custom_mail(@email).deliver_later

    respond_to do |format|
      format.html { redirect_to secretariat_email_url(@email) }
    end
  end

  private

    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_email
      if params[:email_id].present?
        @email = Email.find(params[:email_id])
      else
        @email = Email.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def email_params
      params.require(:email).permit(:subject, :recipients, :content, :image, :file)
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
