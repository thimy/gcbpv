class TrainingSession < ApplicationRecord
  include WithTime
  include WithAttachment
  include WithEditor

  belongs_to :training
  has_one_attached :image
  has_many :attachments, as: :attachable, dependent: :destroy

  validates :name, presence: true
  validates :training, presence: true
  validates :date, presence: true
  validates :city, presence: true

  enum :status, "Public" => 0, "Privé" => 1

  scope :ordered, -> { order(date: :desc, start_time: :desc)}
end
