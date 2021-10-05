# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Notification.all.delete_all
Like.all.delete_all
Post.all.delete_all
Comment.all.delete_all
Friendship.all.delete_all
FriendRequest.all.delete_all
User.all.delete_all

User.create(name: "John", last_name: "Pans", email: "johnpans_thepeoplenetwork@gmail.com", password: "a good password")

User.create(name: "Jane", last_name: "Doe", email: "janedoe_thepeoplenetwork@gmail.com", password: "a good password")

User.create(name: "Sammantha", last_name: "Holmes", email: "sammanthaholmes_thepeoplenetwork@gmail.com", password: "a good password")