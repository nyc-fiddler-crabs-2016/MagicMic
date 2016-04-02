user1 = User.create(username: "steve", email: "email@1.com", password: "password")
user2 = User.create(username: "steve2", email: "email@2.com", password: "password")
user3 = User.create(username: "steve3", email: "email@3.com", password: "password")
user4 = User.create(username: "steve4", email: "email@4.com", password: "password")

broadcast1 = Broadcast.create(topic: "The State of the Onion", speaker_id: 1 )
broadcast2 = Broadcast.create(topic: "Rails Magic and How to Use It", speaker_id: 1 )
broadcast3 = Broadcast.create(topic: "The Secrets of the Rails Wizards", speaker_id: 1 )
broadcast4 = Broadcast.create(topic: "Beware the Coming of the Nice Age", speaker_id: 4 )
broadcast5 = Broadcast.create(topic: "MarioKart Racers: Where Are They Now?", speaker_id: 4 )


UserBroadcast.create(user_id: 2, broadcast_id: 1)
UserBroadcast.create(user_id: 3, broadcast_id: 1)
UserBroadcast.create(user_id: 4, broadcast_id: 1)


UserBroadcast.create(user_id: 2, broadcast_id: 2)
UserBroadcast.create(user_id: 3, broadcast_id: 2)
UserBroadcast.create(user_id: 4, broadcast_id: 2)


UserBroadcast.create(user_id: 2, broadcast_id: 3)
UserBroadcast.create(user_id: 3, broadcast_id: 3)
UserBroadcast.create(user_id: 4, broadcast_id: 3)

UserBroadcast.create(user_id: 1, broadcast_id: 4)
UserBroadcast.create(user_id: 2, broadcast_id: 4)
UserBroadcast.create(user_id: 3, broadcast_id: 4)

UserBroadcast.create(user_id: 1, broadcast_id: 5)
UserBroadcast.create(user_id: 2, broadcast_id: 5)
UserBroadcast.create(user_id: 3, broadcast_id: 5)

