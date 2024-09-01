# Preview all emails at http://localhost:3000/rails/mailers/subscription_mailer
class SubscriptionMailerPreview < ActionMailer::Preview
  def custom_mail
    email = Email.last
    SubscriptionMailer.custom_mail(email)
  end
end
