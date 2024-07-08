class SubbedKidWorkshops < ActiveRecord::Migration[7.1]
  def change
    create_table :subbed_kid_workshops do |t|
      t.references :kid_workshop_slot, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.text :comment
      t.integer :option

      t.timestamps
    end
    
    remove_reference :subscriptions, :kid_workshop_slot
  end
end
