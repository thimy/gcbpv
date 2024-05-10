class CreateEditions < ActiveRecord::Migration[7.1]
  def change
    create_table :editions do |t|
      t.string :name
      t.text :description
      t.string :format
      t.decimal :price
      t.string :image

      t.timestamps
    end
  end
end
