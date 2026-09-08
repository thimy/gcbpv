class PostsController < SecretariatController
  include WithTableConcern
  include WithFileConcern

  before_action :authenticate_admin
  before_action :query
  before_action :set_post, only: %i[ show edit update destroy ]

  decorates_assigned :posts, :post

  SORT_ATTRIBUTES = ["created_at"]

  # GET /posts or /posts.json
  def index
    set_tab_data

    respond_to do |format|
      format.html
      format.atom
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @categories = Category.all
    @category_list = Category.all.map{|category|
      {
        value: category.id,
        text: category.name
      }
    }
  end

  # GET /posts/1/edit
  def edit
    @selected_categories = @post.categories.map{|category| {text: category.name, value: category.id}}.to_json
    @categories = Category.all
    @category_list = Category.all.map{|category|
      {
        value: category.id,
        text: category.name
      }
    }
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        @post.save_attachments
        format.html { redirect_to post_url(@post), notice: "L’article a bien été enregistré." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @post.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        @post.save_attachments
        format.html { redirect_to post_url(@post), notice: "L’article a bien été modifié." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @post.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "L’article a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  def send_post
    @post = Post.find(params[:post_id])
    SubscriptionMailer.custom_mail(@post).deliver_later

    respond_to do |format|
      format.html { redirect_to post_url(@post) }
    end
  end

  private

    def query
      params[:q]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      if params[:post][:published_at].blank? && params[:post][:status] == "Public"
        params[:post][:published_at] = DateTime.now
      end
      params.require(:post).permit(:title, :content, :cover, :status, :file, :published_at, :event_id, :category_ids => [])
    end
    

    def set_records
      @pagy, @posts = paginate_records(Post.ordered)
    end
    
    def default_sort_attribute
      SORT_ATTRIBUTES.first
    end

    def valid_sort_attribute?(attribute)
      SORT_ATTRIBUTES.include?(attribute)
    end
end
