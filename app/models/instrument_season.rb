class InstrumentSeason < ApplicationRecord
  belongs_to :season
  belongs_to :instrument

  validates :season, presence: true
  validates :instrument, presence: true
end
