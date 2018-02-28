require 'rails_helper'

RSpec.describe Post, type: :model do
  # create new instance of Post class
  let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") }

  # test has attributes title and body
  describe "attributes" do
   it "has title and body attributes" do
     expect(post).to have_attributes(title: "New Post Title", body: "New Post Body")
   end
 end
end
