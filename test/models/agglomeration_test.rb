require "test_helper"

class AgglomerationTest < ActiveSupport::TestCase
  test "should not save agglomeration without a name" do
    agglomeration = Agglomeration.new
    assert_not agglomeration.save, "Agglomeration has no name"
  end
end
