require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  # create a parent topic named my_topic
  let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
  # change how create my_post so that will belong to my_topic
  let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  # CP 21 -- remove bc replace w/above
  #  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  # CP 21-- now that nesting, don't need index view bc display in show view of parent topic
  # describe "GET #index" do
  #   it "returns http success" do
  #     get :index
  #     expect(response).to have_http_status(:success)
  #   end
  #
  #   it "assigns [my_post] to @posts" do
  #     get :index
  #
  #     expect(assigns(:posts)).to eq([my_post])
  #   end
  # end

#Checkpoint 18

  describe "GET show" do
     it "returns http success" do
       #pass {id:my_post.id} to show as a parameter.  parameters passed to params hash
       get :show, params: { topic_id: my_topic.id, id: my_post.id }
       expect(response).to have_http_status(:success)
     end
     it "renders the #show view" do
       get :show, params: { topic_id: my_topic.id, id: my_post.id }
       expect(response).to render_template :show
     end
     it "assigns my_post to @post" do
       get :show, params: { topic_id: my_topic.id, id: my_post.id }
       expect(assigns(:post)).to eq(my_post)
     end
   end

  describe "GET new" do
  # when new invoked, new and unsaved Post object created
    it "returns http success" do
      get :new, params: { topic_id: my_topic.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, params: { topic_id: my_topic.id }
      expect(response).to render_template :new
    end

    it "instantiates @post" do
      get :new, params: { topic_id: my_topic.id }
      expect(assigns(:post)).not_to be_nil
    end
  end

  # Checkpoint 19

  describe "GET edit" do
   it "returns http success" do
     get :edit, params: { topic_id: my_topic.id, id: my_post.id }
     expect(response).to have_http_status(:success)
   end

   it "renders the #edit view" do
     get :edit, params: { topic_id: my_topic.id, id: my_post.id }
     expect(response).to render_template :edit
   end

# test that edit assigns correct post to be upddated to @post
   it "assigns post to be updated to @post" do
     get :edit, params: { topic_id: my_topic.id, id: my_post.id }
     post_instance = assigns(:post)

     expect(post_instance.id).to eq my_post.id
     expect(post_instance.title).to eq my_post.title
     expect(post_instance.body).to eq my_post.body
   end
 end

 describe "PUT update" do
   it "updates post with expected attributes" do
     new_title = RandomData.random_sentence
     new_body = RandomData.random_paragraph

     put :update, params: { topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body } }

# test that @post was updated with title and body passed to update, and @post's id was not changed
     updated_post = assigns(:post)
     expect(updated_post.id).to eq my_post.id
     expect(updated_post.title).to eq new_title
     expect(updated_post.body).to eq new_body
   end

   it "redirects to the updated post" do
     new_title = RandomData.random_sentence
     new_body = RandomData.random_paragraph

# expect to be redirected to post show view after update
     put :update, params: { topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body } }
     expect(response).to redirect_to [my_topic, my_post]
   end
 end

 describe "DELETE destroy" do
   it "deletes the post" do
     delete :destroy, params: { topic_id: my_topic.id, id: my_post.id }

# search db for a post with id = my_post_id...returns array
# assign size of array to count, then expect count to =0  (i.e. no matchin post after destroy called)
     count = Post.where({id: my_post.id}).size
     expect(count).to eq 0
   end

   it "redirects to topic show" do
     delete :destroy, params: { topic_id: my_topic.id, id: my_post.id }
     expect(response).to redirect_to my_topic
   end
 end


  describe "POST create" do
  # when create invoked, new object is persisted to the database
    it "increases the number of Post by 1" do
      expect{ post :create, params: { topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Post,:count).by(1)
    end

    it "assigns the new post to @post" do
      post :create, params: { topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      expect(assigns(:post)).to eq Post.last
    end

    it "redirects to the new post" do
      post :create, params: { topic_id: my_topic.id, post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      expect(response).to redirect_to [my_topic, Post.last]
    end
  end

end
