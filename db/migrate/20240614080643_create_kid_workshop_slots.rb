class CreateKidWorkshopSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :kid_workshop_slots do |t|
      t.belongs_to :kid_workshop, null: false, foreign_key: true
      t.belongs_to :city, null: false, foreign_key: true
      t.string :slot_time
      t.integer :day_of_week
      t.integer :frequency

      t.timestamps
    end
  end
end
