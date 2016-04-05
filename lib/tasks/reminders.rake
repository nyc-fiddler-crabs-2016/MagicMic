namespace :reminders do
  desc "TODO"

  task email: :environment do
    Broadcast.where("datetime > ?", DateTime.now).each do |b|
      puts b.topic
    end
    # puts "email"
  end

  desc "TODO"
  task text: :environment do
    send_message
  # end
  end

end


def send_email

end

def send_message
  # (phone_number, alert_message)
    gary_phone = '9175547210'
    joe_phone = '4155598988'
    phone_numbers = [gary_phone,joe_phone]
    account_sid = 'AC1b79196961ed1a2af0f27ecca279cf7f'
    auth_token = '618599501a88e36bb06425b3a55d17bf'
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
