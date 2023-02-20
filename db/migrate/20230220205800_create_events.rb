class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :content
      t.datetime :start_date
      t.datetime :end_date
      t.string :address_first
      t.string :address_second
      t.string :street
      t.string :city

      t.timestamps
    end
  end
end
