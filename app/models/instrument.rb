class Instrument < ApplicationRecord
  has_many :specialties, dependent: :delete_all
  has_many :teachers, through: :specialties
  has_many :courses
  has_many :subscriptions, through: :courses
  has_one_attached :image

  enum :status, "Public" => 0, "Privé" => 1
  scope :active, -> {where(status: 0)}

  validates :name, presence: true

  def cities
    teachers.map { |teacher|
      teacher.cities
    }.flatten.uniq
  end

  def time_period
    if time.present?
      time
    else
      "Horaire à définir"
    end
  end

  def teacher_list
    teachers.map {|teacher|
      teacher.name
  }.join(", ")
  end

  def courses(season: Config.first.season)
    subscriptions = Subscription.joins(:subscription_group).where(subscription_group: { season: season })
    Course.joins(:subscription).where(instrument: self, subscription: subscriptions)
  end
end
