require 'rails_helper'

RSpec.describe Comment, type: :model do
  # # let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") }
  # let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  # let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  # let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }

  # CP31 refactor above
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  let(:comment) { Comment.create!(body: 'Comment Body', post: post, user: user) }

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "Comment Body")
    end
  end


  describe "after_create" do
# initialize a new comment for post
    before do
      @another_comment = Comment.new(body: 'Comment Body', post: post, user: user)
    end

# favorite post,then expect FavoriteMailler to receive a call to new_comment;  save anouther_comment to trigger after_create callback
    it "sends an email to users who have favorited the post" do
      favorite = user.favorites.create(post: post)
      expect(FavoriteMailer).to receive(:new_comment).with(user, post, @another_comment).and_return(double(deliver_now: true))

      @another_comment.save!
    end

# #24
    it "does not send emails to users who haven't favorited the post" do
      expect(FavoriteMailer).not_to receive(:new_comment)

      @another_comment.save!
    end
  end
end
