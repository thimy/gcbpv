class AddCover < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :cover, :string
  end
end
