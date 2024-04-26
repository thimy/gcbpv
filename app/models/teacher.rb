class Teacher < ApplicationRecord
  has_many :specialties, dependent: :delete_all
  has_many :instruments, through: :specialties

  def name
    "#{first_name} #{last_name}"
  end
end
