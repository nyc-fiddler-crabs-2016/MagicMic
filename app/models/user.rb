class User < ActiveRecord::Base
  has_secure_password

  has_many :broadcasts, foreign_key: "speaker_id"


  has_many :reminder_settings
  has_many :saved_broadcasts, through: :reminder_settings, source: :broadcast



end
