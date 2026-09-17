# == Schema Information
#
# Table name: pathway_slots
#
#  id          :bigint           not null, primary key
#  comment     :text
#  day_of_week :integer
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  city_id     :bigint           not null
#  pathway_id  :bigint           not null
#
# Indexes
#
#  index_pathway_slots_on_city_id     (city_id)
#  index_pathway_slots_on_pathway_id  (pathway_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#  fk_rails_...  (pathway_id => pathways.id)
#
class PathwaySlot < ApplicationRecord
  belongs_to :pathway
  belongs_to :city
  has_many :pathway_slot_teachers
  has_many :teachers, through: :pathway_slot_teachers

  validates :pathway, presence: true

  enum :day_of_week, {
    "À définir": 0,
    "Lundi": 1,
    "Mardi": 2,
    "Mercredi": 3,
    "Jeudi": 4,
    "Vendredi": 5,
    "Samedi": 6,
    "Dimanche": 7,
  }

  def teacher_names
    teachers.map {|teacher| teacher.name }.join("/")
  end

  def name
    "#{pathway.name} – #{teacher_names} à #{city.name}"
  end
end
