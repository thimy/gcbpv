class Specialty < ApplicationRecord
  belongs_to :instrument
  belongs_to :teacher
end
