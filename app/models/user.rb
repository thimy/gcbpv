class User < ApplicationRecord
  belongs_to :payor, optional: true
  has_one :student

  delegate :subscription_groups, to: :payor

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  accepts_nested_attributes_for :payor

  validates :email, uniqueness: true, presence: true, format: {with: Devise.email_regexp}
  validates :password, presence: true, on: :create

  def student
    Student.find(student_id)
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
