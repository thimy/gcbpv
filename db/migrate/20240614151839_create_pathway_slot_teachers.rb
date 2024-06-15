class CreatePathwaySlotTeachers < ActiveRecord::Migration[7.1]
  def change
    create_table :pathway_slot_teachers do |t|
      t.belongs_to :pathway, null: false, foreign_key: true
      t.belongs_to :teacher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
