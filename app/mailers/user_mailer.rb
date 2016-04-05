class UserMailer < ApplicationMailer
default from: 'notifications@magicmikedbc.com'

  def welcome_email(user)
    @user = user
    email_with_name = %("#{@user.username}"<#{@user.email}>)
    @url  = 'http://example.com/login'
    mail(to: email_with_name,
         subject: 'Welcome to MagicMic')
  end
end
