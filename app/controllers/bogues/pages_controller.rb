class Bogues::PagesController < SecretariatController
  include WithTableConcern

  before_action :query
  before_action :set_page, only: %i[ show edit update destroy ]

  SORT_ATTRIBUTES = ["created_at", "start_date"]

  # GET /pages/1 or /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @bogue = Bogue.find(params[:bogue_id])
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages or /pages.json
  def create
    @bogue = Bogue.find(params[:bogue_id])
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        @page.save_attachments
        format.html { redirect_to bogue_path(@bogue), notice: "La page a bien été enregistrée." }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1 or /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        @page.save_attachments
        format.html { redirect_to bogue_path(@bogue), notice: "La page a bien été modifiée." }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1 or /pages/1.json
  def destroy
    @page.destroy!

    respond_to do |format|
      format.html { redirect_to secretariat_bogue_url(@bogue), notice: "La page a bien été supprimée." }
      format.json { head :no_content }
    end
  end

  def upload_file
    file_params = {
      file: params[:file] || params[:image]
    }

    if params[:file].present?
      file_params[:name] = params[:file].original_filename if params[:file].original_filename.present?
      file_params[:extension] = Rack::Mime::MIME_TYPES.invert[params[:file].content_type].sub(".", "") if params[:file].content_type.present?
      file_params[:size] = params[:file].size if params[:file].size.present?
    end

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

  def send_page
    @page = Page.find(params[:page_id])
    SubscriptionMailer.custom_mail(@page).deliver_later

    respond_to do |format|
      format.html { redirect_to secretariat_page_url(@page) }
    end
  end

  private

    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
      @bogue = Bogue.find(params[:bogue_id]) || @page.bogue
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params[:page][:slug] = "#{params[:page][:name].parameterize}"
      params[:page][:bogue_id] = params[:bogue_id]
      params.require(:page).permit(:name, :content, :status, :file, :start_date, :end_date, :slug, :page_type, :location, :city, :comment, :bogue_id, :highlight)
    end
    
    def set_records
      @pagy, @pages = paginate_records(Page.ordered)
    end
    
    def default_sort_attribute
      SORT_ATTRIBUTES.first
    end

    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES.include?(attribute)
    end
end
