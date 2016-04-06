class UserMailer < ApplicationMailer

default from: 'notifications@magicmikedbc.com'

  EMAIL_SUBJECTS = {
    hour_of_reminder: "Your broadcast starts in an hour",
    day_before_reminder: "You have a saved broadcast tomorrow",
    broadast_updated: "updated",#{broadcast.topic}
    broadcast_cancelled: " cancelled"#{broadcast.topic}
  }

  def welcome_email(user)
    @user = user
    email_with_name = %("#{@user.username}"<#{@user.email}>)
    @url  = 'http://example.com/login'
    mail(to: email_with_name,
         subject: 'Welcome to MagicMic')
  end

  def day_before_reminder(broadcast, user)
    @broadcast = broadcast
    @user = user
    email_with_name = %("#{@user.username}"<#{@user.email}>)
    mail(to: email_with_name,
       subject: "Reminder: You have a saved MagicMic broadcast tomorrow")
  end

  def hour_of_reminder(broadcast, user)
    @broadcast = broadcast
    @user = user
    email_with_name = %("#{@user.username}"<#{@user.email}>)
    mail(to: email_with_name,
       subject: "Reminder: You have a saved MagicMic broadcast within the hour.")
  end

  def broadcast_updated(broadcast, user)
    @broadcast = broadcast
    @user = user
    email_with_name = %("#{@user.username}"<#{@user.email}>)
    mail(to: email_with_name,
         subject: "A MagicMic broadcast you saved has been changed")
  end

  def broadcast_cancelled(broadcast, user)
      @broadcast = broadcast
      @user = user
      email_with_name = %("#{@user.username}"<#{@user.email}>)
      mail(to: email_with_name,
         subject: "Upcoming Broadcast #{broadcast.topic} Cancelled")
  end

  # def build_and_send_reminders(broadcast, event_type)
  #   emailable_users, textable_users = User.remindable(broadcast)
  #   emailable_users.each do |user|
  #      UserMailer.broadcast_updated(broadcast, user).deliver_now
  #    end
  #   textable_users.each do |user|
  #     UserTexter.send_message(user, event_type)
  #   end
  # end

  # build_and_send_reminders(broadcast, :day_before_reminder)
  # build_and_send_reminders(broadcast, :broadcast_cancelled)
  # build_and_send_reminders(broadcast, :hour_of_reminder)



 
end

