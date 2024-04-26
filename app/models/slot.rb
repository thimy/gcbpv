class Slot < ApplicationRecord
  include WithTime

  belongs_to :teacher
  belongs_to :city
end
