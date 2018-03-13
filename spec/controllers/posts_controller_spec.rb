require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_post] to @posts" do
      get :index

      expect(assigns(:posts)).to eq([my_post])
    end
  end

#Checkpoint 18

  describe "GET show" do
     it "returns http success" do
       #pass {id:my_post.id} to show as a parameter.  parameters passed to params hash
       get :show, params: { id: my_post.id }
       expect(response).to have_http_status(:success)
     end
     it "renders the #show view" do
       get :show, params: { id: my_post.id }
       expect(response).to render_template :show
     end
     it "assigns my_post to @post" do
       get :show, params: { id: my_post.id }
       expect(assigns(:post)).to eq(my_post)
     end
   end

  describe "GET new" do
  # when new invoked, new and unsaved Post object created
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end

  # Checkpoint 19

  describe "GET edit" do
   it "returns http success" do
     get :edit, params: { id: my_post.id }
     expect(response).to have_http_status(:success)
   end

   it "renders the #edit view" do
     get :edit, params: { id: my_post.id }
# expect edit view to render when edit a post
     expect(response).to render_template :edit
   end

# test that edit assigns correct post to be upddated to @post
   it "assigns post to be updated to @post" do
     get :edit, params: { id: my_post.id }

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

     put :update, params: { id: my_post.id, post: {title: new_title, body: new_body } }

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
     put :update, params: { id: my_post.id, post: {title: new_title, body: new_body } }
     expect(response).to redirect_to my_post
   end
 end

 describe "DELETE destroy" do
   it "deletes the post" do
     delete :destroy, params: { id: my_post.id }
# search db for a post with id = my_post_id...returns array
# assign size of array to count, then expect count to =0  (i.e. no matchin post after destroy called)
     count = Post.where({id: my_post.id}).size
     expect(count).to eq 0
   end

   it "redirects to posts index" do
     delete :destroy, params: { id: my_post.id }
# expect redirect to posts index view after deleting a post
     expect(response).to redirect_to posts_path
   end
 end



  describe "POST create" do
  # when create invoked, new object is persisted to the database
    it "increases the number of Post by 1" do
      expect{ post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(Post,:count).by(1)
    end

    it "assigns the new post to @post" do
      post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      expect(assigns(:post)).to eq Post.last
    end

    it "redirects to the new post" do
      post :create, params: { post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      expect(response).to redirect_to Post.last
    end
  end

end
