class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.references :season, null: false, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
