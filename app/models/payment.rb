class Payment < ApplicationRecord
  belongs_to :subscription_group

  enum :payment_method, "Espèces" => 0, "Chèque" => 1, "Virement" => 2
end
