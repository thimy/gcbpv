class Email < ApplicationRecord
  include EmailImagesHandler
  include WithAttachment
  include WithEditor
  has_many :email_images, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
end
