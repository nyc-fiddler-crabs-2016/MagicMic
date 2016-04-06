class Broadcast < ActiveRecord::Base
  # validates :
  # after_save :notify_by_email

  belongs_to :speaker, class_name: "User"

  has_many :reminder_settings, dependent: :destroy
  has_many :audience_members, through: :reminder_settings, source: :user

  def self.search(search)
    if search
      Broadcast.where('topic iLIKE ?', "%#{search}%")
    else
      Broadcast.all
    end
  end


  def self.upcoming
    Broadcast.where("datetime > ?", DateTime.now)
  end

  def self.an_hour_away
    Broadcast.where("datetime > ?", DateTime.now + 60.minutes).where('datetime < ?', DateTime.now + 120.minutes)
  end

  def self.a_day_away
    Broadcast.where('broadcasts.datetime >= ?', Date.today + 1.day).where('broadcasts.datetime < ?', Date.today + 2.day)
  end

  def readable_time
    self.datetime.strftime("%A, %B %d, %Y at %l%p")
  end

  # def self.belongs_to_current_user?
  #   current_user == self.speaker
  #   binding.pry
  # end
end



