class Archives::EditionsController < BaseController
  before_action :set_edition, only: %i[ show ]

  def index
    @editions = Edition.all
  end

  def show
    @other_editions = Edition.where.not(id: params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_edition
      @edition = Edition.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def edition_params
      params.require(:edition).permit(:name)
    end
end
