# == Schema Information
#
# Table name: editions
#
#  id          :bigint           not null, primary key
#  comment     :text
#  description :text
#  format      :string
#  image       :string
#  name        :string
#  price       :decimal(, )
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Edition < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true
  validates :format, presence: true
  validates :price, presence: true
  validates :status, presence: true

  enum :status, "Public" => 0, "Privé" => 1
end
