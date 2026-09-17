# == Schema Information
#
# Table name: configs
#
#  id         :bigint           not null, primary key
#  banner     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  season_id  :bigint           not null
#
# Indexes
#
#  index_configs_on_season_id  (season_id)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id)
#
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
