class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }

  VALID_STATUSES = ["public", "private", "archived"]
  validates :status, inclusion: { in: VALID_STATUSES }
  
  def archived?
    status == "archived"
  end
end
