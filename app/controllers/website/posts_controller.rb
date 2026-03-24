class Website::PostsController < BaseController
  include Pagy::Backend
  before_action :set_post, only: %i[ show ]
  MAX_PER_PAGE = 10

  def index
    @pagy, @posts = pagy(Post.latest, items: MAX_PER_PAGE)
  end

  def show
    render layout: "post"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:name)
    end
end
