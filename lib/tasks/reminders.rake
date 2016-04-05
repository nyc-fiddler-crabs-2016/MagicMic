require "#{Rails.root}/app/helpers/application_helper"
# include ApplicationHelper

namespace :reminders do
  desc "TODO"
  task daily: :environment do
     broadcasts = Broadcast.a_day_away
        broadcasts.each do |broadcast|
          # reminder_settings.where(day_before_sent:false)
          UserMailer.day_before_reminder(broadcast)
        end
     end

  desc "TODO"
  task hourly: :environment do
    broadcasts = Broadcast.an_hour_away
    broadcasts.each do |broadcast|
      # reminder_settings.where(hour_before_sent:false)
      UserMailer.hour_of_reminder(broadcast)
    end
  end


  #  reminders.each do |reminder|
  #    send_text_message(reminder.broadcast) if reminder.text_message
  #    send_email_reminder(reminder.broadcast) if reminder.email_reminder
  #    reminder.day_before_sent = true
  #    reminder.save
  # end


end
