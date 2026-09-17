# == Schema Information
#
# Table name: pathways
#
#  id          :bigint           not null, primary key
#  comment     :text
#  description :text
#  name        :string
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Pathway < ApplicationRecord
  has_many :pathway_slots

  accepts_nested_attributes_for :pathway_slots
end
