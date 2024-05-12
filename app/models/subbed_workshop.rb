class SubbedWorkshop < ApplicationRecord
  belongs_to :workshop
  belongs_to :subscription
end
