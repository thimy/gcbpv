class SubscriptionMailer < ApplicationMailer
  default from: "ecole@gcbpv.org"
  layout 'mailer'

  def standard_mail
    @subscriptions = params[:subscriptions].map{|subscription| subscription.email}.join(", ")
    @subject = params[:subject]
    @content = params[:content]
    mail(to: @subscriptions, subject: @subject)
  end

  def custom_mail(email)
    @subject = email.subject
    @recipients = email.recipients
    @content = email.formatted_content
    mail(to: @recipients, subject: @subject, content: @content)
  end

  def confirm_subscription(user)
    mail(
      to: user.payor.payor_email,
      subject: "[GCBPV] Confirmation de votre inscription"
    )
  end
end
