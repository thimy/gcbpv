# == Schema Information
#
# Table name: training_sessions
#
#  id          :bigint           not null, primary key
#  city        :string
#  comment     :text
#  content     :text
#  date        :date
#  end_time    :string
#  guest       :string
#  image       :text
#  location    :string
#  name        :string
#  price       :decimal(, )
#  start_time  :string
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  training_id :bigint           not null
#
# Indexes
#
#  index_training_sessions_on_training_id  (training_id)
#
# Foreign Keys
#
#  fk_rails_...  (training_id => trainings.id)
#
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
