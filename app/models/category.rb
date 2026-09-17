# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  cover1     :string
#  cover2     :string
#  cover3     :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  has_and_belongs_to_many :posts

  validates :name, presence: true
end
