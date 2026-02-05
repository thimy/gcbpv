class Config < ApplicationRecord
  belongs_to :season

  validates :season, presence: true

  before_create :check_for_existing
  before_destroy :check_for_existing

  def self.load
    config = Config.first

    if config.nil?
      config = Config.create
    end

    config
  end

  private

  def check_for_existing
    raise ActiveRecord::RecordInvalid if Config.count >= 1
  end
end
