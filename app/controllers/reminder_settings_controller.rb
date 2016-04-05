class ReminderSettingsController < ApplicationController

  def create
    @reminder_setting = ReminderSetting.new(reminder_params)
    if @reminder_setting.save
      flash[:success] = 'Reminder saved'
      redirect_to :root
    else
      flash[:error] = 'Reminder not saved'
      redirect_to :back
    end
  end

  private

  def reminder_params
    params.require(:reminder_setting).permit(:broadcast_id, :email_reminder, :text_message).merge(user: current_user)
  end


end

