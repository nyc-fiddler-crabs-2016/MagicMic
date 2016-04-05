class CreateReminderSettings < ActiveRecord::Migration
  def change
    create_table :reminder_settings do |t|

      t.references :user, index: true, foreign_key: true
      t.references :broadcast, index: true, foreign_key: true
      t.boolean    :email_reminder, default: false
      t.boolean    :text_message, default: false

      t.timestamps null: false
    end
  end
end
