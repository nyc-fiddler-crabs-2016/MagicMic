class ReminderSettingsController < ApplicationController

  def create
    @reminder_setting = ReminderSetting.new(reminder_params)
    if @reminder_setting.save
      render text: 'Reminder saved'

    else
      render text: 'Reminder not saved'

    end

  end

  private
  def reminder_params
    params.require(:reminder_setting).permit(:broadcast_id, :email_reminder, :text_message).merge(user: current_user)
  end


end

