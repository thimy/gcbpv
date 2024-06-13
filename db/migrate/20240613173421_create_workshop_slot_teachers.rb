class CreateWorkshopSlotTeachers < ActiveRecord::Migration[7.1]
  def change
    create_table :workshop_slot_teachers do |t|
      t.belongs_to :teacher, null: false, foreign_key: true
      t.belongs_to :workshop_slot, null: false, foreign_key: true

      t.timestamps
    end

    add_column :workshop_slots, :frequency, :integer
    remove_reference :workshop_slots, :teacher
  end
end
