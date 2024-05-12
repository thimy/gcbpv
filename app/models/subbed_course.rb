class SubbedCourse < ApplicationRecord
  belongs_to :course
  belongs_to :subscription
end
