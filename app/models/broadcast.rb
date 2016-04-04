class Broadcast < ActiveRecord::Base
  # validates :
  # after_save :notify_by_email

  belongs_to :speaker, class_name: "User"
  has_many :user_broadcasts, dependent: :destroy
  has_many :listeners, through: :user_broadcasts, source: :user




  def self.upcoming
    Broadcast.where("datetime > ?", DateTime.now)
  end

  def readable_time
    self.datetime.strftime("%A, %B %d, %Y at %l%p")
  end

  def self.reset_broadcast_list
    Broadcast.where("datetime < ?", DateTime.now - 120.minutes).delete_all
  end

  # def invite_list(emails)
   # array_of_emails = emails
  # end

  # def notify_by_email

  # end

end



