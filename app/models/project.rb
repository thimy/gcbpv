class Project < ApplicationRecord
  include WithEditor

  has_many :project_students
  has_many :students, through: :project_students
  belongs_to :season

  enum :status, "Public" => 0, "Privé" => 1

  scope :visible, -> {where(status: 0)}
end
