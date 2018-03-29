# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'random_data'

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
     topic: topics.sample,
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph
   )
 end
 posts = Post.all


# Assignment 21  Create SponsoredPosts
25.times do
  SponsoredPost.create!(
    topic: topics.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph,
    price: RandomData.random_int
  )
end

 # Create Comments
 100.times do
   Comment.create!(
 # call sample on array returned by Post.all,  pick random element
     post: posts.sample,
     body: RandomData.random_paragraph
   )
 end

 puts "Seed finished"
 puts "#{Topic.count} topics created"
 puts "#{Post.count} posts created"
 puts "#{SponsoredPost.count} sponsoredposts created"
 puts "#{Comment.count} comments created"
