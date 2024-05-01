class CategoriesPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :categories_posts do |t|
      t.references :categories
      t.references :posts
    end
  end
end
