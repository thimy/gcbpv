class TrainingStudent < ApplicationRecord
  belongs_to :training_session
  belongs_to :student
end
