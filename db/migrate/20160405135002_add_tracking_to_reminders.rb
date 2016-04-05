class AddTrackingToReminders < ActiveRecord::Migration
  def change
    add_column :reminder_settings, :day_before_sent, :boolean, null: false, default: false
    add_column :reminder_settings, :hour_before_sent, :boolean, null: false, default: false
  end
end
