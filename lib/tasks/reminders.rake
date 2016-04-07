namespace :reminders do
  desc "SEND DAILY REMINDERS"
  task daily: :environment do
     broadcasts = Broadcast.a_day_away
     broadcasts.each do |broadcast|
       send_scheduled_reminders
        end
     end

  desc "SEND HOURLY REMINDERS"
  task hourly: :environment do
    broadcasts = Broadcast.an_hour_away
    broadcasts.each do |broadcast|
      send_scheduled_reminders(true)
    end
  end

  def send_scheduled_reminders(hourly = false)
    emailable_users, textable_users = User.remindable(@broadcast)
     emailable_users.each do |user|
        if hourly
            UserMailer.hour_of_reminder(broadcast, user).deliver_now
        else
            UserMailer.day_before_reminder(broadcast, user).deliver_now
        end
    end
    textable_users.each do |user|
        if hourly
          UserTexter.send_message(user, :hour_of_reminder)
        else
          UserTexter.send_message(user, :day_before_reminder)
        end
    end
  end


end
          # reminder_settings.where(day_before_sent:false)
          # reminder_settings.where(hour_before_sent:false)
