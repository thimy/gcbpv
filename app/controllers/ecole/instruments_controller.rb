class Ecole::InstrumentsController < EcoleController
  before_action :set_instrument, only: %i[ show ]

  def index
    @instruments = Instrument.active.order(:name)
    @plan = Config.first.season.plan
  end

  def show
    @other_instruments = Instrument.active.where.not(id: params[:id]).order(:name)
    @slots = Slot.all.order(:city_id).group_by{ |slot| [slot.city.name, slot.day_of_week, slot.teacher]}
    @cities = City.all.select do |city|
      city.slots.select { |slot|
        slot.teacher.instruments.include?(@instrument)
      }.count > 0
    end
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
