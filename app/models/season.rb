class Season < ApplicationRecord
  belongs_to :plan

  def name
    "#{start_year}-#{start_year+1}"
  end

  def student_count
    "#{Subscription.joins(:subscription_group).where(subscription_group: {season_id: Config.first.season.id}).size} élèves"
  end
end
