class RemovePayorColumn < ActiveRecord::Migration[7.1]
  def change
    remove_reference :subscription_groups, :payor
    remove_reference :users, :payor
  end
end
