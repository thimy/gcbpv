class Attachment < ApplicationRecord
  has_one_attached :file
  belongs_to :attachable, polymorphic: true, optional: true
end
