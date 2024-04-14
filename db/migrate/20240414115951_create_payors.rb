class CreatePayors < ActiveRecord::Migration[7.1]
  def change
    create_table :payors do |t|
      t.string :last_name
      t.string :first_name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
