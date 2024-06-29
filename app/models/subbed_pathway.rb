class SubbedPathway < ApplicationRecord
  belongs_to :pathway_slot
  belongs_to :subscription
end
