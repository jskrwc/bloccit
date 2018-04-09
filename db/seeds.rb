# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'random_data'

  # Create Users
  5.times do
    User.create!(
      name:     RandomData.random_name,
      email:    RandomData.random_email,
      password: RandomData.random_sentence
    )
  end
  users = User.all

  # Create Topics
  15.times do
    Topic.create!(
      name:        RandomData.random_sentence,
      description: RandomData.random_paragraph
    )
  end
  topics = Topic.all


 # Create Posts
 50.times do
 # create with bang -- ! raises error if problem w/ data we're seeding
   Post.create!(
     user:  users.sample,
     topic: topics.sample,
     title: RandomData.random_sentence,
     body:  RandomData.random_paragraph
   )
 end
 posts = Post.all

 # Create Comments
 100.times do
   Comment.create!(
 # call sample on array returned by Post.all,  pick random element
     post: posts.sample,
     body: RandomData.random_paragraph
   )
 end

# # add me as user for test purposes
# user = User.first
# user.update_attributes!(
#   email: 'jim@knopf.io',
#   password: 'helloworld'
# )

# Create and admin user
admin = User.create!(
  name: 'Admin User',
  email:  'admin@example.com',
  password: 'helloworld',
  role: 'admin'
)

# Create a member
member = User.create!(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld'
)

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Topic.count} topics created"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"
