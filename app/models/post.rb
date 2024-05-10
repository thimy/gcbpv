class Post < ApplicationRecord
  include WithTime

  has_and_belongs_to_many :categories
  belongs_to :event, optional: true, required: false
  has_one_attached :image

  scope :latest, -> { where(status: "Public").order(published_at: :desc) }

  VALID_STATUSES = ["Privé", "Public", "Archivé"]
  validates :status, presence: true, inclusion: { in: VALID_STATUSES }

  def publication_datetime
    format_datetime(published_at)
  end
end
