class TrainingSession < ApplicationRecord
  include WithTime
  belongs_to :training
  has_one_attached :image
end
