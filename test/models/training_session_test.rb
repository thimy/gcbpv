require "test_helper"

# == Schema Information
#
# Table name: training_sessions
#
#  id          :bigint           not null, primary key
#  city        :string
#  comment     :text
#  content     :text
#  date        :date
#  end_time    :string
#  guest       :string
#  image       :text
#  location    :string
#  name        :string
#  price       :decimal(, )
#  start_time  :string
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  training_id :bigint           not null
#
# Indexes
#
#  index_training_sessions_on_training_id  (training_id)
#
# Foreign Keys
#
#  fk_rails_...  (training_id => trainings.id)
#
class TrainingSessionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
