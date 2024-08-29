class SubscriptionMailer < ApplicationMailer
  default from: "ecole@gcbpv.org"
  layout 'mailer'

  def standard_mail
    @subscriptions = params[:subscriptions].map{|subscription| subscription.email}.join(", ")
    @subject = params[:subject]
    @content = params[:content]
    mail(to: @subscriptions, subject: @subject)
  end
end
