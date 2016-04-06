user1 = User.create!(username: "steve", email: "thefirststevedave@gmail.com", password: "password")
user2 = User.create!(username: "steve2", email: "thesecondstevedave@gmail.com", password: "password")
user3 = User.create!(username: "steve3", email: "thethirdstevedave@gmail.com", password: "password")
user4 = User.create!(username: "mattgaryjoe", email: "mattgaryjoe@gmail.com", password: "password")

broadcast1 = Broadcast.create!(topic: "The State of the Onion", speaker_id: 1 )
broadcast2 = Broadcast.create!(topic: "Rails Magic and How to Use It", speaker_id: 1 )
broadcast3 = Broadcast.create!(topic: "The Secrets of the Rails Wizards", speaker_id: 1, datetime: DateTime.new(2015, 5,15, 19,00, -5))
broadcast4 = Broadcast.create!(topic: "Beware the Coming of the Nice Age", speaker_id: 4, datetime: DateTime.new(2015, 9,15, 20,00, -5))
broadcast5 = Broadcast.create!(topic: "MarioKart Racers: Where Are They Now?", speaker_id: 4, datetime: DateTime.new(2016, 4,6, 21,00, -5))


ReminderSetting.create!(user_id: 2, broadcast_id: 1)
ReminderSetting.create!(user_id: 3, broadcast_id: 1, email_reminder: true, text_message: true)
ReminderSetting.create!(user_id: 4, broadcast_id: 1, email_reminder: true, text_message: true)


ReminderSetting.create!(user_id: 2, broadcast_id: 2)
ReminderSetting.create!(user_id: 3, broadcast_id: 2, email_reminder: true, text_message: true)
ReminderSetting.create!(user_id: 4, broadcast_id: 2, email_reminder: true, text_message: true)


ReminderSetting.create!(user_id: 2, broadcast_id: 3)
ReminderSetting.create!(user_id: 3, broadcast_id: 3, email_reminder: true, text_message: true)
ReminderSetting.create!(user_id: 4, broadcast_id: 3, email_reminder: true, text_message: true)

ReminderSetting.create!(user_id: 1, broadcast_id: 4, email_reminder: true, text_message: true)
ReminderSetting.create!(user_id: 2, broadcast_id: 4)
ReminderSetting.create!(user_id: 3, broadcast_id: 4, email_reminder: true, text_message: true)

ReminderSetting.create!(user_id: 1, broadcast_id: 5, email_reminder: true, text_message: true)
ReminderSetting.create!(user_id: 2, broadcast_id: 5)
ReminderSetting.create!(user_id: 3, broadcast_id: 5, email_reminder: true, text_message: true)
