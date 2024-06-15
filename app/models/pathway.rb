class Pathway < ApplicationRecord
  has_many :pathway_slots

  accepts_nested_attributes_for :pathway_slots
end
