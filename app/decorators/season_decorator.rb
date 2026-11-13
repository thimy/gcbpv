class SeasonDecorator < ApplicationDecorator
  delegate_all

  def adult_count
    "#{subbed_workshops.adults.registered(self).size} (+#{subbed_workshops.adults.inquired(self).size})"
  end

  def kid_count
    "#{subbed_workshops.youth.registered(self).size} (+#{subbed_workshops.youth.inquired(self).size})"
  end
end
