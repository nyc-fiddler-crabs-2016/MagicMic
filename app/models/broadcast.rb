class Broadcast < ActiveRecord::Base
  # validates :
  # after_save :notify_by_email

  belongs_to :speaker, class_name: "User"
  has_many :user_broadcasts
  has_many :listeners, through: :user_broadcasts, source: :user






  # def invite_list(emails)
      # array_of_emails = emails
  # end

  def notify_by_email

  end

end



