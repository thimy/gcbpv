class SubbedWorkshop < ApplicationRecord
  belongs_to :workshop_slot
  belongs_to :subscription
end
