class Membership < ActiveRecord::Migration[7.1]
  def change
    add_column :plans, :membership_price, :integer
    add_column :plans, :special_workshop_price, :decimal
    add_column :pathway_slots, :comment, :text
    add_column :workshops, :workshop_type, :integer
    remove_column :slots, :end_time
    rename_column :slots, :start_time, :slot_time
  end
end
