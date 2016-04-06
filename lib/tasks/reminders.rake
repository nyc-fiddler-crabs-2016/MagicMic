# require "#{Rails.root}/app/helpers/application_helper"
# include ApplicationHelper

namespace :reminders do
  desc "SEND DAILY REMINDERS"

  task daily: :environment do
     broadcasts = Broadcast.a_day_away
        broadcasts.each do |broadcast|
          emailable_users, textable_users = User.remindable(@broadcast)
          emailable_users.each do |user|
            UserMailer.hour_of_reminder(broadcast, user).deliver_now
          end
          textable_users.each do |user|
              UserTexter.send_message(user)
          end
          # reminder_settings.where(day_before_sent:false)
        end
     end

  desc "SEND HOURLY REMINDERS"
  task hourly: :environment do
    broadcasts = Broadcast.an_hour_away
    broadcasts.each do |broadcast|
      emailable_users, textable_users = User.remindable(@broadcast)
      emailable_users.each do |user|
        UserMailer.hour_of_reminder(broadcast, user).deliver_now
      end
      textable_users.each do |user|
        UserTexter.send_message(user)
      end
      # reminder_settings.where(hour_before_sent:false)
    end
  end


  #  reminders.each do |reminder|
  #    send_text_message(reminder.broadcast) if reminder.text_message
  #    send_email_reminder(reminder.broadcast) if reminder.email_reminder
  #    reminder.day_before_sent = true
  #    reminder.save
  # end


end
