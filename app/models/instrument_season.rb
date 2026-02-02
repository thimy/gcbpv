class InstrumentSeason < ApplicationRecord
  belongs_to :season
  belongs_to :instrument
end
