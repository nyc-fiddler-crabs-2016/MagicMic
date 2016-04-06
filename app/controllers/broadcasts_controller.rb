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
    if @broadcast.update(broadcast_params)
      emailable_users, textable_users = User.remindable(@broadcast)
      emailable_users.each do |user|
        UserMailer.broadcast_updated(@broadcast, user).deliver_now
      end
      redirect_to :root
    else
      redirect_to :back
    end
  end

  def destroy
    @broadcast = Broadcast.find(params[:id])
    emailable_users, textable_users = User.remindable(@broadcast)
    emailable_users.each do |user|
        UserMailer.broadcast_cancelled(@broadcast, user).deliver_now
    @broadcast.destroy
    end
    redirect_to :root
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

  private

  def broadcast_params
    params.require(:broadcast).permit(:topic, :datetime, :duration).merge(speaker_id: current_user.id)
  end
end
