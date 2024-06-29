class Season < ApplicationRecord
  belongs_to :plan

  def name
    "#{start_year}-#{start_year+1}"
  end

  def student_count
    "#{Subscription.where(season_id: Config.first.season.id).size} élèves"
  end
end
