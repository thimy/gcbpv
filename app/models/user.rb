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
class User < ApplicationRecord
  belongs_to :household, optional: true
  belongs_to :student, optional: true
  belongs_to :teacher, optional: true

  delegate :subscription_groups, to: :household

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  accepts_nested_attributes_for :household

  validates :email, uniqueness: true, presence: true, format: {with: Devise.email_regexp}
  validates :password, presence: true, on: :create

  def student
    Student.find(student_id) if student_id.present?
  end

  def teacher
    Teacher.find(teacher_id) if teacher_id.present?
  end

  def subscriptions
    student.subscriptions if student_id.present?
  end

  def current_subscription
    subscriptions.find { |subscription|
      subscription.subscription_group.season == Config.first.season
    } if subscriptions.present?
  end
end
