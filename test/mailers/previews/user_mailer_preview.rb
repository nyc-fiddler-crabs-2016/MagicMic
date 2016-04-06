# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  EMAIL_SUBJECTS = {
    hour_of_reminder: "Your broadcast starts in an hour",
    day_before_reminder: "You have a saved broadcast tomorrow",
    broadast_updated: "updated",#{broadcast.topic}
    broadcast_cancelled: " cancelled"#{broadcast.topic}
  }

  def welcome_email(user)
    UserMailer.welcome_email(broadcast.first, user.first)
  end

  def day_before_reminder(broadcast, user)
    UserMailer.day_before_reminder(broadcast.first, user.first)
  end
  def hour_of_reminder(broadcast, user)
    UserMailer.hour_of_reminder(broadcast.first, user.first)
  end

  def broadcast_updated(broadcast, user)
    UserMailer.broadcast_cancelled(broadcast.first, user.first)
  end
  def broadcast_cancelled(broadcast, user)
     UserMailer.broadcast_updated(broadcast.first, user.first)
  end
end
