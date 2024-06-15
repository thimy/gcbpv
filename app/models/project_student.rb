class ProjectStudent < ApplicationRecord
  belongs_to :project_instance
  belongs_to :student
end
