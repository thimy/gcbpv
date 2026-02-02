class WorkshopSlotSeason < ApplicationRecord
  belongs_to :season
  belongs_to :workshop_slot
end
