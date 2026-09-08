class Bogues::PagesController < SecretariatController
  include WithTableConcern
  include WithFileConcern

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
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @page.errors, status: :unprocessable_content }
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
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @page.errors, status: :unprocessable_content }
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
