class WelcomeMailer < ApplicationMailer
    default from: 'infoyd2h@gmail.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to YD2H')
  end
end
