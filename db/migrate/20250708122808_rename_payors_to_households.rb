class RenamePayorsToHouseholds < ActiveRecord::Migration[7.1]
  def change
    rename_table :payors, :households
    remove_reference :students, :payor
    add_reference :subscription_groups, :household
    add_reference :users, :household
  end
end
