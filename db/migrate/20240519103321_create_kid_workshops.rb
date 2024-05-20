class CreateKidWorkshops < ActiveRecord::Migration[7.1]
  def change
    create_table :kid_workshops do |t|
      t.string :name
      t.string :frequency
      t.text :description
      t.integer :workshop_type
      t.integer :status

      t.timestamps
    end

    add_column :workshops, :kid_friendly, :boolean
  end
end
