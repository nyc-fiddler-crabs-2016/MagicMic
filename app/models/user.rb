class User < ActiveRecord::Base
  has_secure_password
  validates :username, :email, presence: true, uniqueness: true

  has_many :broadcasts, foreign_key: "speaker_id"


  has_many :reminder_settings
  has_many :saved_broadcasts, through: :reminder_settings, source: :broadcast

  def self.remindable (broadcast)
    emailable_users = User.get_requesters(broadcast, :email_reminder)
    textable_users = User.get_requesters(broadcast, :text_message)
    [emailable_users, textable_users]
   end

  def self.get_requesters(broadcast, reminder_type)
   broadcast.audience_members.includes(:reminder_settings).where(reminder_settings:{reminder_type => true})
  end

  def user_owns?
    broadcast.speaker == self
  end
  
  def current_user
      @current_user ||= User.find_by(id: session[:user_id])
  end

end
