class TrainingSession < ApplicationRecord
  include WithTime
  include WithAttachment
  include WithEditor

  belongs_to :training
  has_one_attached :image
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :training_students
  has_many :students, through: :training_students

  validates :name, presence: true
  validates :training, presence: true
  validates :date, presence: true
  validates :city, presence: true

  enum :status, "Public" => 0, "Privé" => 1

  scope :ordered, -> { order(date: :desc, start_time: :desc)}
  scope :active, -> (season) { includes(:training).where(training: {season: season}) }
end
