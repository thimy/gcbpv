class Teacher < ApplicationRecord
  has_many :specialties, dependent: :delete_all
  has_many :instruments, through: :specialties
  has_many :slots
  has_many :cities, through: :slots
  has_one_attached :photo

  def name
    "#{first_name} #{last_name}"
  end
end
