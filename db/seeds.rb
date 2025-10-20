# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# db/seeds.rb

puts "Seeding database..."

# === 1. Create Users ===
# We use find_or_create_by! to avoid creating duplicate users on multiple runs.
# We search by 'email', which Devise ensures is unique.

puts "Creating users..."
user1 = User.find_or_create_by!(email: 'user1@example.com') do |user|
  user.username = 'GuiSysLima'
  user.email = 'guilherme@gmail.com'
  user.password = 'password'
  user.password_confirmation = 'password'
end

user2 = User.find_or_create_by!(email: 'user2@example.com') do |user|
  user.username = 'admin'
  user.email = 'admin@admin.com'
  user.password = 'password'
  user.password_confirmation = 'password'
end

user3 = User.find_or_create_by!(email: 'user3@example.com') do |user|
  user.username = 'test'
  user.email = 'test@test.com'
  user.password = 'password'
  user.password_confirmation = 'password'
end

puts "Created #{User.count} users."


# === 2. Create Friendships ===
# We'll create one accepted friendship and one pending request.

puts "Creating friendships..."

# User 1 sent a request to User 2, which was accepted.
Friendship.find_or_create_by!(user: user1, friend: user2) do |friendship|
  friendship.status = 'accepted'
end

# User 3 sent a request to User 1, which is still pending.
Friendship.find_or_create_by!(user: user3, friend: user1) do |friendship|
  friendship.status = 'pending'
end

puts "Created #{Friendship.count} friendships."

# TODO:
# === 3. Create Chatroom Messages ===
# We'll clear old messages and create a few new ones.
# This assumes your message model is named 'Message' and has 'body' and 'user'

puts "Seeding complete!"