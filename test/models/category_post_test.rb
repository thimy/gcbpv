require "test_helper"

class CategoryPostTest < ActiveSupport::TestCase
  test "should save with a category" do
    category_post = CategoryPost.new(post: Post.new)
    assert_not category_post.save, "CategoryPost relationship doesn't have a category"
  end
  test "should save with a post" do
    category_post = CategoryPost.new(category: "EMT")
    assert_not category_post.save, "CategoryPost relationship doesn't have a post"
  end
end
