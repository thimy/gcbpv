class CreateStudents < ActiveRecord::Migration[7.1]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.integer :gender
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
