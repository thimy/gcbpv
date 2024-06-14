class Project < ApplicationRecord
  belongs_to :season

  enum :status, "Public" => 0, "Privé" => 1
end
