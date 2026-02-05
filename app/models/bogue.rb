class Bogue < ApplicationRecord
  include WithTime
  include WithAttachment
  include WithEditor

  has_many :posts
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :events
  has_many :pages

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :slug, presence: true

  enum :status, "Public" => 0, "Privé" => 1
  scope :active, -> {where(status: 0)}
  scope :ordered, -> { order(start_date: :desc) }
end
