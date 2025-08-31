class TrainingSession < ApplicationRecord
  include WithTime
  include WithAttachment
  include WithEditor

  belongs_to :training
  has_one_attached :image
  has_many :attachments, as: :attachable, dependent: :destroy

  enum :status, "Public" => 0, "Privé" => 1

  scope :ordered, -> { order(date: :desc, start_time: :desc)}
end
