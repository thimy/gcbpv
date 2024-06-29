class Project < ApplicationRecord
  has_many :project_instances

  accepts_nested_attributes_for :project_instances

  enum :status, "Public" => 0, "Privé" => 1
end
