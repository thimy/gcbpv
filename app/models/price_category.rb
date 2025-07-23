class PriceCategory < ApplicationRecord
  has_many :workshops
  has_many :plan_price_categories
  accepts_nested_attributes_for :plan_price_categories

  def price(season: Config.first.season)
    plan_price_categories.find_by(plan: season.plan).price
  end

  def obc_price(season: Config.first.season)
    pricing = plan_price_categories.find_by(plan: season.plan)
    pricing.obc_price || pricing.price + pricing.price * season.plan.obc_markup / 100
  end

  def outbounds_price(season: Config.first.season)
    pricing = plan_price_categories.find_by(plan: season.plan)
    pricing.outbounds_price || pricing.price + pricing.price * season.plan.outbounds_markup / 100
  end
end
