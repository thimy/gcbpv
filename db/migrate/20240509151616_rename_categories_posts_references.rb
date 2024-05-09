class RenameCategoriesPostsReferences < ActiveRecord::Migration[7.1]
  def change
    remove_reference :categories_posts, :categories
    remove_reference :categories_posts, :posts
    
    add_reference :categories_posts, :category
    add_reference :categories_posts, :post
  end
end
