class EmailImage < ApplicationRecord
  has_one_attached :image
  belongs_to :email, optional: true

  validates :email, presence: true
end
