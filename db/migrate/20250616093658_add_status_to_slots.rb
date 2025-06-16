class AddStatusToSlots < ActiveRecord::Migration[7.1]
  def change
    add_column :slots, :status, :integer
  end
end
