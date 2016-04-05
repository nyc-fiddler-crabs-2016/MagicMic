class ReminderSetting < ActiveRecord::Base

  validates :user, uniqueness: {scope: :broadcast, message: "You have already added that to your saved broadcasts"}

  belongs_to :user
  belongs_to :broadcast
end
