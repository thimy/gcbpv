class Project < ApplicationRecord
  include WithEditor

  has_many :project_students
  has_many :students, through: :project_students
  belongs_to :season

  validates :name, presence: true
  validates :status, presence: true

  enum :status, "Public" => 0, "Privé" => 1

  scope :visible, -> {where(status: 0)}
end
