class Account::SubscriptionController < ApplicationController
  before_action :authenticate_user!
  layout "account"

  def show
    @students = Student.where(payor_id: current_user.id)
    @subscriptions = Subscription.where(students: @students).includes(:workshops, :d_classes)
    @plan = Season.last.plan
    @total = 0
    @subscriptions.map{|sub| @total += sub.sessions_and_workshops_total}
  end
end
