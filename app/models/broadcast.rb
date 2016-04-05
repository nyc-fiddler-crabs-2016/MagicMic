class Broadcast < ActiveRecord::Base
  # validates :
  # after_save :notify_by_email

  belongs_to :speaker, class_name: "User"

  has_many :reminder_settings, dependent: :destroy
  has_many :audience_members, through: :reminder_settings, source: :user

  def self.search(search)
    if search
      Broadcast.where('topic iLIKE ?', "%#{search}%")
    else
      Broadcast.all
    end
  end


  def self.upcoming
    Broadcast.where("datetime > ?", DateTime.now)
  end


  def self.upcoming
    Broadcast.where("datetime > ?", DateTime.now)
  end

  def readable_time
    self.datetime.strftime("%A, %B %d, %Y at %l%p")
  end

  # def self.reset_broadcast_list
  #   Broadcast.where("datetime < ?", DateTime.now - 120.minutes).destroy_all
  # end


  # def invite_list(emails)
   # array_of_emails = emails
  # end

  # def notify_by_email

  # end
  def self.send_message
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
    binding.pry
  end

end



