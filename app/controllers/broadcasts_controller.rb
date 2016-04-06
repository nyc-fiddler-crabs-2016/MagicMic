# require 'twilio_ruby'

class BroadcastsController < ApplicationController
include ApplicationHelper
 before_action :ensure_ownership, only:[:edit,:update,:destroy]

 def index
    # @broadcasts = Broadcast.all
    @broadcasts = Broadcast.search(params[:search])
  end

  def new
    @broadcast = Broadcast.new
  end

  def create
    if logged_in?
      @broadcast = Broadcast.new(broadcast_params)
      if @broadcast.save
        redirect_to :root
      else
        redirect_to :back
      end
    else
      flash[:error] = "You need to be logged in to create a broadcast"
      redirect_to :back
    end
  end

  def show
      # send_message
    if broadcast_exists?
      @broadcast = Broadcast.find(params[:id])
      @reminder_settings = ReminderSetting.find_by(broadcast_id: @broadcast.id)
      @reminder_setting = ReminderSetting.new
    else
      flash[:error]= "No soap, radio."
      redirect_to :root
    end
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

      textable_users.each do |user|
        binding.pry
        UserTexter.send_message(user)
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
    end

    textable_users.each do |user|
        UserTexter.send_message(user)
    end
    @broadcast.destroy
    redirect_to :root
  end

  # def belongs_to_current_user?
  #   binding.pry
  #   current_user.id == self.speaker_id
  # end

  def ensure_ownership
    # binding.pry
    @broadcast = Broadcast.find(params[:id])
    unless current_user.id == @broadcast.speaker_id
      flash.alert = "Try again"
      redirect_to root_path
    end
  end

  def current_broadcast
    @broadcast = Broadcast.find_by(id:(params[:id]))
  end

  def broadcast_exists?
    current_broadcast != nil
  end

  private

  def broadcast_params
    params.require(:broadcast).permit(:topic, :datetime, :duration).merge(speaker_id: current_user.id)
  end
end
