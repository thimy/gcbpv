class RemoveKidTables < ActiveRecord::Migration[7.1]
  def change
    drop_table :kid_workshop_slot_teachers
    drop_table :subbed_kid_workshops
    drop_table :kid_workshop_slots
    drop_table :kid_workshops
  end
end
