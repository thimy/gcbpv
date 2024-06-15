class ProjectInstance < ApplicationRecord
  belongs_to :season
  belongs_to :project
  has_many :project_students
  has_many :students, through: :project_students

  enum :status, "Public" => 0, "Privé" => 1
end
