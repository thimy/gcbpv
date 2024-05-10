class Training < ApplicationRecord
  has_many :training_sessions
  belongs_to :season
end
