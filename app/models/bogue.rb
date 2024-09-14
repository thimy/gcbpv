class Bogue < ApplicationRecord
  include WithTime
  include WithAttachment
  include WithEditor

  has_many :posts
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :events

  enum :status, "Public" => 0, "Privé" => 1
  scope :active, -> {where(status: 0)}
  scope :ordered, -> { order(start_date: :desc) }
end
