class CreateAgglomerations < ActiveRecord::Migration[7.1]
  def change
    create_table :agglomerations do |t|
      t.string :name
      t.timestamps
    end
    add_column :cities, :postcode, :string
    add_reference :cities, :agglomeration
  end
end
