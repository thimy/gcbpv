class Project < ApplicationRecord
  belongs_to :season
  has_many :project_instances

  accepts_nested_attributes_for :project_instances

  enum :status, "Public" => 0, "Privé" => 1
end
