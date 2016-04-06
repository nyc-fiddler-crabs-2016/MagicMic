class UserMailer < ApplicationMailer

default from: 'notifications@magicmikedbc.com'
  TEXT_MESSAGE_BODY = {
    hour_of_reminder: "Greetings from MagicMic! Your broadcast starts in an hour",
    day_before_reminder: "Greetings from MagicMic! You have a saved broadcast tomorrow",
    broadast_updated: "Greetings from MagicMic! A broadcast you saved has been changed",
    broadcast_cancelled: "Greetings from MagicMic! The broadcast you saved,  has been cancelled,"#{broadcast.topic},
  }

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

  def day_before_reminder(broadcast)
    build_and_send_reminders(broadcast, :day_before_reminder)
  end

  def hour_of_reminder(broadcast)
   build_and_send_reminders(broadcast, :hour_of_reminder)
  end

  def broadcast_updated(broadcast)
    build_and_send_reminders(broadcast, :broadcast_updated)
  end

  def broadcast_cancelled(broadcast)
    build_and_send_reminders(broadcast, :broadcast_cancelled)
  end

private

  def build_and_send_reminders(broadcast, event_type)
    @broadcast = broadcast
    emailable_users, textable_users = User.remindable(@broadcast)

    emailable_users.each do |user|
      email_with_name = %("#{user.username}"<#{user.email}>)
      mail(to: email_with_name,
         subject: EMAIL_SUBJECTS[event_type]).deliver_now
     end

    textable_users.each do |user|
      send_message(user, event_type)
    end
  end

  def send_message(user, event_type)
  # (phone_number, alert_message)
    account_sid = ENV["TWILIO_SID"]
    auth_token = ENV["TWILIO_TOKEN"]
    twilio_number = '+13477044254'
    @client = Twilio::REST::Client.new account_sid, auth_token
    @client.account.messages.create({
      :from => twilio_number,
      :to => user.phone_number,
      :body => TEXT_MESSAGE_BODY[event_type]
      })
    # binding.pry
  rescue Twilio::REST::RequestError =>error
    puts error.message
  end
end
  # def send_reminders(emailable_users, textable_users)

  #   emailable_users.each do |user|
  #     email_with_name = %("#{user.username}"<#{user.email}>)
  #     mail(to: email_with_name,
  #        subject: "#{broadcast.topic} cancelled").deliver_now
  #    end

  #   textable_users.each do |user|
  #     send_message
  #   end
  # end
