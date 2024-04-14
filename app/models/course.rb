class Course < ApplicationRecord
  belongs_to :slot
  belongs_to :instrument
end
