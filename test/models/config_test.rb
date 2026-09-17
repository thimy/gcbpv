# == Schema Information
#
# Table name: configs
#
#  id         :bigint           not null, primary key
#  banner     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  season_id  :bigint           not null
#
# Indexes
#
#  index_configs_on_season_id  (season_id)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id)
#
# require "test_helper"

# class ConfigTest < ActiveSupport::TestCase
#   test "should not allow another record to be created" do
#     configs(:one)
#     config_2 = Config.new
#     assert_not config_2.save, "Config should be unique"
#   end
#   test "should not allow destruction of record" do
#     config = configs(:one)
#     assert_not config.destroy, "Config cannot be destroyed"
#   end
# end
