# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'random_data'

 # Create Posts
 50.times do
 # create with bang -- ! raises error if problem w/ data we're seeding
   Post.create!(
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph
   )
 end

 # Assignment 16
 puts "#{Post.count}"
 unique_post = Post.find_or_create_by(
   title:  'This is a unique sample post.',
   body:   'This is a unique body.'
 )
 puts "#{Post.count}"


 posts = Post.all

 # Create Comments
 100.times do
   Comment.create!(
 # call sample on array returned by Post.all,  pick random element
     post: posts.sample,
     body: RandomData.random_paragraph
   )
 end

 Comment.find_or_create_by!(body: "This is a unique comment", post: unique_post)

 puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"
