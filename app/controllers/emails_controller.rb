class EmailsController < SecretariatController
  before_action :set_email, only: %i[ update destroy ]

  # POST /emails or /emails.json
  def create
    @email = Email.new(email_params)

    respond_to do |format|
      if @email.save
        @email.save_email_images
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

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def email_params
      params.require(:email).permit(:subject, :recipients, :body, :image)
    end
end
