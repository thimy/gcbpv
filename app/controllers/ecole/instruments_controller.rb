class Ecole::InstrumentsController < WebsiteController
  before_action :set_instrument, only: %i[ show ]

  def index
    @instruments = Instrument.all
  end

  def show
    @other_instruments = Instrument.where.not(id: params[:id])
    @slots = Slot.all.order(:city_id).group_by{ |slot| [slot.city.name, slot.day_of_week, slot.teacher]}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instrument
      @instrument = Instrument.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def instrument_params
      params.require(:instrument).permit(:name)
    end
end
