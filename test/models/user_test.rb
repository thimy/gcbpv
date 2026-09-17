require "test_helper"

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  household_id           :bigint
#  student_id             :bigint
#  teacher_id             :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_household_id          (household_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_student_id            (student_id)
#  index_users_on_teacher_id            (teacher_id)
#
class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
