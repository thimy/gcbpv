class CreateTeachers < ActiveRecord::Migration[7.1]
  def change
    create_table :teachers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.references :instrument, null: false, foreign_key: true
      t.text :description
      t.string :photo

      t.timestamps
    end
  end
end
