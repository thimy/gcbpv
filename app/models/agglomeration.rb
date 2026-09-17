# == Schema Information
#
# Table name: agglomerations
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Agglomeration < ApplicationRecord
  has_many :cities

  validates :name, presence: true
end
