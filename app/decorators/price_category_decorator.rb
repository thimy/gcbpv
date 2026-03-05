class PriceCategoryDecorator < ApplicationDecorator
  filter_attributes :price,
                    :obc_price,
                    :outbounds_price,
                    :with => :number_to_currency
end
