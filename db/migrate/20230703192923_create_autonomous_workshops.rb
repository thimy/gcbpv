class CreateAutonomousWorkshops < ActiveRecord::Migration[7.0]
  def change
    create_table :autonomous_workshops do |t|
      t.string :name
      t.string :location
      t.decimal :price

      t.timestamps
    end
  end
end
