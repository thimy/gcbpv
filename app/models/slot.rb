# == Schema Information
#
# Table name: slots
#
#  id          :bigint           not null, primary key
#  comment     :text
#  day_of_week :integer
#  frequency   :integer
#  slot_time   :string
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  city_id     :bigint           not null
#  teacher_id  :bigint           not null
#
# Indexes
#
#  index_slots_on_city_id     (city_id)
#  index_slots_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#  fk_rails_...  (teacher_id => teachers.id)
#
class Slot < ApplicationRecord
  include WithTime

  belongs_to :teacher
  belongs_to :city
  has_many :courses
  has_many :subscriptions, through: :courses
  has_many :slot_seasons
  has_many :seasons, through: :slot_seasons
  has_many :specialties, through: :teacher
  has_many :instruments, through: :specialties

  validates :teacher, presence: true
  validates :city, presence: true
  validates :day_of_week, presence: true
  validates :slot_time, presence: true
  validates :frequency, presence: true
  validates :status, presence: true

  scope :visible, -> {where(status: 0)}
  scope :active, -> (season) {includes(:slot_seasons).where(slot_seasons: {season: season})}
  scope :with_instrument, -> (instrument) {where(teacher: Teacher.with_instrument(instrument))}

  enum :status, "Public" => 0, "Privé" => 1

  enum :day_of_week, {
    "Jour à définir": 0,
    "Lundi": 1,
    "Mardi": 2,
    "Mercredi": 3,
    "Jeudi": 4,
    "Vendredi": 5,
    "Samedi": 6,
    "Dimanche": 7,
    "Jour variable": 8
  }

  enum :frequency, {
    "Fréquence à définir": 0,
    "Hebdomadaire": 1,
    "Toutes les deux semaines": 2,
    "Semaines paires": 3,
    "Semaines impaires": 4,
    "Tous les mois": 5,
    "Six séances dans l'année": 6,
    "5x4 séances par répertoire": 7,
    "Fréquence variable": 8
  }

  def name
    "#{teacher.name} à #{city.name} #{datetime}"
  end

  def name_without_city
    "#{teacher.name} #{datetime}"
  end

  def name_without_teacher
    "#{city.name} - #{datetime}"
  end

  def datetime
    if day_of_week.present? && slot_time.present?
      "le #{day_of_week} #{slot_time}".downcase
    elsif day_of_week.present?
      "le #{day_of_week} - horaires à définir"
    elsif slot_time.present?
      "jour à définir - #{slot_time}".downcase
    else
      "jour et horaires à définir"
    end
  end

  def courses
    Course.joins(:subscription, :slot).where(slot: self)
  end

  def student_count
    courses.count
  end
end
