require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "should save with a name" do
    category = Category.new(name: "EMT"))
    assert_not category.save, "Category doesn't have a name"
  end
end
