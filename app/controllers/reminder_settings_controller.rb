class ReminderSettingsController < ApplicationController

  def new
    @reminder_setting = ReminderSetting.new
  end

  def create
    @reminder_setting = ReminderSetting.new(user_id: current_user.id, broadcast_id: params[:format], email_reminder: params[:reminder_setting][:email_reminder], text_message: params[:reminder_setting][:text_message])
    binding.pry
    if @reminder_setting.save

    else

    end

  end


end

