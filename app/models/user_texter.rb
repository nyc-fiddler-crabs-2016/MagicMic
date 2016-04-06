class UserTexter
   TEXT_MESSAGE_BODY = {
      hour_of_reminder: "Greetings from MagicMic! Your broadcast starts in an hour",
      day_before_reminder: "Greetings from MagicMic! You have a saved broadcast tomorrow",
      broadast_updated: "Greetings from MagicMic! A broadcast you saved has been changed",
      broadcast_cancelled: "Greetings from MagicMic! The broadcast you saved,  has been cancelled,"#{broadcast.topic},
  }

  def self.send_message(user)
      account_sid = ENV["TWILIO_SID"]
      auth_token = ENV["TWILIO_TOKEN"]
      twilio_number = '+13477044254'
      @client = Twilio::REST::Client.new(account_sid, auth_token)
      @client.account.messages.create(
        { :from => twilio_number,
            :to => user.phone_number,
            :body => "Greetings from MagicMic! A broadcast you saved has been changed"}
      )
    rescue Twilio::REST::RequestError =>error
      puts error.message
    end
  end
#:body => TEXT_MESSAGE_BODY[event_type]}
