class TrainingSession < ApplicationRecord
  belongs_to :training
  has_one_attached :image
end
