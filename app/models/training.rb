class Training < ApplicationRecord
  has_many :training_sessions
  belongs_to :season

  accepts_nested_attributes_for :training_sessions

  enum :status, "Public" => 0, "Privé" => 1
end
