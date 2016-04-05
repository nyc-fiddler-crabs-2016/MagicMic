# require 'twilio_ruby'

class BroadcastsController < ApplicationController
include ApplicationHelper
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
    # @topic = @broadcast.topic
    if @broadcast.update(broadcast_params)
       UserMailer.broadcast_updated(broadcast)

      redirect_to :root
    else
      redirect_to :back
    end
  end

  def destroy
    broadcast = Broadcast.find(params[:id])
    UserMailer.broadcast_cancelled(broadcast)
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
end
