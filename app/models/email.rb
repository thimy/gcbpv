class Email < ApplicationRecord
  include EmailImagesHandler
  include WithEditor
  has_many :email_images, dependent: :destroy
end
