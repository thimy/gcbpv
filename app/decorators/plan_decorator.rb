class PlanDecorator < ApplicationDecorator
  filter_attributes :kids_class_price,
                    :kids_class_price_obc,
                    :kids_class_price_outbounds,
                    :class_price,
                    :class_price_obc,
                    :class_price_outbounds,
                    :workshop_price,
                    :workshop_price_obc,
                    :workshop_price_outbounds,
                    :with => :number_to_currency
end
