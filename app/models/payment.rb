class Payment < ApplicationRecord
  belongs_to :subscription_group

  enum :payment_method, "Espèces" => 0, "Chèque" => 1, "Virement" => 2, "Chèques Vacances" => 3, "Coupon Culture Sport Redon" => 4, "Forfait Passion CAF" => 5, "Chèques Vacances Connect" => 6
end
