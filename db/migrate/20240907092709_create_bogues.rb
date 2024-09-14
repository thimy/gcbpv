class CreateBogues < ActiveRecord::Migration[7.1]
  def change
    create_table :bogues do |t|
      t.string :name
      t.jsonb :content
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status
      t.string :slug
      t.text :comment

      t.timestamps
    end

    create_table :bogue_pages do |t|
      t.string :name
      t.jsonb :content
      t.string :location
      t.string :city
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status
      t.string :type
      t.string :slug
      t.text :comment

      t.timestamps
    end
  end
end
