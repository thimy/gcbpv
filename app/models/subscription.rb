class Subscription < ApplicationRecord
  belongs_to :student
  has_many :courses
  has_many :subbed_workshops
  has_many :workshops, through: :subbed_workshops
  belongs_to :payor, optional: true
  belongs_to :season

  accepts_nested_attributes_for :student, :courses, :subbed_workshops, :workshops, allow_destroy: true

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
