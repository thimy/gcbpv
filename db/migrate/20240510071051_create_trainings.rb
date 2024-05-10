class CreateTrainings < ActiveRecord::Migration[7.1]
  def change
    create_table :trainings do |t|
      t.string :name
      t.text :description
      t.integer :session_count
      t.decimal :price
      t.references :season, null: false, foreign_key: true

      t.timestamps
    end
  end
end
