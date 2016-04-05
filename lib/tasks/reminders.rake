namespace :reminders do
  desc "TODO"

  task daily: :environment do
    Broadcast.where("datetime > ?", DateTime.now).where(reminder_sent: false).each do |b|
      puts b.topic
    end
    # puts "email"
  end

  desc "TODO"
  task hourly: :environment do
    send_message
  # end
  end

end


def send_day_before
   reminders = ReminderSetting.joins(:broadcast).where('broadcasts.datetime >= ?', Date.today + 1.day).where('broadcasts.datetime < ?', Date.today + 2.day).where(day_before_sent: false)

   reminders.each do |reminder|
     send_text_message(reminder.broadcast) if reminder.text_message
     send_email_reminder(reminder.broadcast) if reminder.email_reminder
     reminder.day_before_sent = true
     reminder.save
  end
end

ENV['']

def send_email

end

def send_message
  # (phone_number, alert_message)
    gary_phone = '9175547210'
    joe_phone = '4155598988'
    phone_numbers = [gary_phone,joe_phone]
    account_sid = ENV["TWILIO_SID"]
    auth_token = ENV["TWILIO_TOKEN"]
    twilio_number = '+13477044254'
    # @twilio_number = twilio_number
    @client = Twilio::REST::Client.new account_sid, auth_token
    # binding.pry
    # probably need a for each user
    @client.account.messages.create({
      :from => twilio_number,
      :to => joe_phone,
      :body => "Greetings from MagicMic! Your broadcast is coming up soon"
      })
    # binding.pry
  rescue Twilio::REST::RequestError =>error
    puts error.message
  end

def find_users_with_texts
  User.includes(:reminder_settings).where(reminder_settings:{text_message:true}).all
end

def find_users_with_email_reminders
  User.includes(:reminder_settings).where(reminder_settings: {email_reminder:true}).all
end
