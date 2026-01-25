class AddCoverToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :cover, :string
    add_column :categories, :cover1, :string
    add_column :categories, :cover2, :string
    add_column :categories, :cover3, :string
  end
end
