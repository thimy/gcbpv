class CleanDb < ActiveRecord::Migration[7.1]
  def change
    remove_column :categories, :type
    remove_column :events, :image

    add_column :households, :secondary_last_name, :string
    add_column :households, :secondary_first_name, :string
  end
end
