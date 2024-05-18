class Training < ApplicationRecord
  has_many :training_sessions
  belongs_to :season

  accepts_nested_attributes_for :training_sessions
end
