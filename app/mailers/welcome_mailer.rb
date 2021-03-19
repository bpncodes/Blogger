class WelcomeMailer < ApplicationMailer
  default from: 'mabezat777@gmail.com'

  def welcome_email(user)
    @user = user
    mail(to: email_address_with_name(@user.email, @user.username), subject: "New User Signup: #{@user.email}")
  end

  def custom_mail(user, message, comment)
    @user = user
    @comment = comment
    mail(to: email_address_with_name(@user.email, @user.username), subject: message)
  end
end
