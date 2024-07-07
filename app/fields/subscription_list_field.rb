require "administrate/field/base"

class SubscriptionListField < Administrate::Field::Base
  def to_s
    data
  end
end
