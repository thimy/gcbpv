class Subscription < ApplicationRecord
  belongs_to :student
  has_many :subbed_workshops, dependent: :delete_all
  has_many :courses
  has_many :workshops, through: :subbed_workshops
  belongs_to :payor
  belongs_to :season

  accepts_nested_attributes_for :courses, :workshops

  validates :season, presence: true
  validates :student, presence: true, uniqueness: { scope: :season,
    message: "a déjà une inscription pour cette année" }

  enum status: {
    "Demande d’information": 0,
    "Inscrit – à régler": 1,
    "Inscrit – réglé": 2,
    "À rembourser": 3
  }

end
