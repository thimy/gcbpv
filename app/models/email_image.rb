class EmailImage < ApplicationRecord
  has_one_attached :image
  belongs_to :email, optional: true
end
