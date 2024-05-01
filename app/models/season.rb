class Season < ApplicationRecord
  belongs_to :plan

  def name
    "#{start_year}-#{start_year+1}"
  end
end
