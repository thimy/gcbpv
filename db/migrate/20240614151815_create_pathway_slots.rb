class CreatePathwaySlots < ActiveRecord::Migration[7.1]
  def change
    create_table :pathway_slots do |t|
      t.belongs_to :pathway, null: false, foreign_key: true
      t.belongs_to :city, null: false, foreign_key: true
      t.integer :day_of_week

      t.timestamps
    end
  end
end
