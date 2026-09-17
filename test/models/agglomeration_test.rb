require "test_helper"

# == Schema Information
#
# Table name: agglomerations
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AgglomerationTest < ActiveSupport::TestCase
  test "should not save agglomeration without a name" do
    agglomeration = Agglomeration.new
    assert_not agglomeration.save, "Agglomeration has no name"
  end
end
