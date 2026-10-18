class WorkshopDecorator < ApplicationDecorator
  delegate_all

  def get_total_subscriptions(season)
    registered_subs = subbed_workshops.registered(season)
    inquired_subs = (subbed_workshops.inquired(season) + subbed_workshops.registered(@season).optional).uniq
    inquired_subs.present? ? "#{registered_subs.confirmed.size} (+#{inquired_subs.size})" : registered_subs.confirmed.size
  end
end
