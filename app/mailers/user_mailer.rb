class UserMailer < ApplicationMailer
default from: 'notifications@magicmikedbc.com'

  def welcome_email(user)
    @user = user
    email_with_name = %("#{@user.username}"<#{@user.email}>)
    @url  = 'http://example.com/login'
    mail(to: email_with_name,
         subject: 'Welcome to MagicMic')
  end

  def broadast_details_updated(broadcast)
  end

  def broadcast_cancelled(broadcast)
    @broadcast = broadcast
    users = broadcast.audience_members
    users.each do |user|
      email_with_name = %("#{user.username}"<#{user.email}>)
      mail(to: email_with_name,
         subject: "#{broadcast.topic} cancelled")
  end
end
end
