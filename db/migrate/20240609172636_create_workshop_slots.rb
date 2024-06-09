class CreateWorkshopSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :workshop_slots do |t|
      t.belongs_to :teacher, null: false, foreign_key: true
      t.belongs_to :workshop, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.string :slot_time
      t.integer :day_of_week

      t.timestamps
    end
  end
end
