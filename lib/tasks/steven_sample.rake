
# def send_day_before
#    reminders = ReminderSetting.joins(:broadcast).where('broadcasts.datetime >= ?', Date.today + 1.day).where('broadcasts.datetime < ?', Date.today + 2.day).where(day_before_sent: false)

#    reminders.each do |reminder|
#      send_text_message(reminder.broadcast) if reminder.text_message
#      send_email_reminder(reminder.broadcast) if reminder.email_reminder
#      reminder.day_before_sent = true
#      reminder.save
#    end

#  end
