require 'rails_helper'

RSpec.describe Post, type: :model do
  # create new instance of Post class
  # let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") }
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
# create parent topic for post
  let(:topic) { Topic.create!(name: name, description: description) }
# associate post with topic
  let(:post) { topic.posts.create!(title: title, body: body) }

  it { is_expected.to belong_to(:topic) }

  # test has attributes title and body
  describe "attributes" do
   it "has title and body attributes" do
     # expect(post).to have_attributes(title: "New Post Title", body: "New Post Body")
     expect(post).to have_attributes(title: title, body: body)
   end
 end
end
