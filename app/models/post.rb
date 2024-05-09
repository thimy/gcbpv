class Post < ApplicationRecord
  has_and_belongs_to_many :categories
  belongs_to :event, optional: true, required: false
  has_one_attached :image

  VALID_STATUSES = ["Privé", "Public", "Archivé"]
  validates :status, presence: true, inclusion: { in: VALID_STATUSES }

  def public?
    status == "Public"
  end

  def archived?
    status == "Archivé"
  end
end
