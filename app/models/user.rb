class User < ActiveRecord::Base
  has_secure_password

  has_many :broadcasts, foreign_key: "speaker_id"

  has_many :user_broadcasts
  has_many :broadcasts_heard, through: :user_broadcasts, source: :broadcast

  has_many :reminder_settings
  has_many :broadcasts_saved, through: :reminder_settings, source: :broadcast



end
