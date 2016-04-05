# require 'twilio_ruby'

class BroadcastsController < ApplicationController

 # before_action :ensure_ownership


  def index
    # @broadcasts = Broadcast.all
    @broadcasts = Broadcast.search(params[:search])
  end

  def new
    @broadcast = Broadcast.new
  end

  def create
    @broadcast = Broadcast.new(broadcast_params)
    if @broadcast.save
      redirect_to :root
    else
      redirect_to :back
    end
  end

  def show
      # send_message
    @broadcast = Broadcast.find(params[:id])
    @reminder_settings = ReminderSetting.find_by(broadcast_id: @broadcast.id)
    @reminder_setting = ReminderSetting.new
  end

  def edit
    @broadcast = Broadcast.find(params[:id])
  end

  def update
    @broadcast = Broadcast.find(params[:id])
    if @broadcast.update(broadcast_params)
      redirect_to :root
    else
      redirect_to :back
    end
  end

  def destroy
    broadcast = Broadcast.find(params[:id])
    UserMailer.broadcast_cancelled(broadcast).deliver_now
    broadcast.destroy
    redirect_to root_path
  end

  # def belongs_to_current_user?
  #   current_user.id == self.creator_id
  # end

  # def ensure_ownership
  #   unless self.belongs_to_current_user?
  #     flash.alert = "Try again"
  #     redirect_to root_path
  #   end
  # end

  # def trigger_sms_alert

  #   @users = User.all
  #   @message = "Hey! You have a broadcast at #{broadcast.readable_time}"

  #   if user.id.upcoming && user.broadcast
  #     send_message
  #   end

  #   @user.each do |user|


  # end

  private

  def broadcast_params
    params.require(:broadcast).permit(:topic, :datetime, :duration).merge(speaker_id: current_user.id)
  end

#take arguements for phone number and body
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
    binding.pry
  end
end
