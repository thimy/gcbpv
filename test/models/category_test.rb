require "test_helper"

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  cover1     :string
#  cover2     :string
#  cover3     :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CategoryTest < ActiveSupport::TestCase
  test "should save with a name" do
    category = Category.new(name: "EMT"))
    assert_not category.save, "Category doesn't have a name"
  end
end
