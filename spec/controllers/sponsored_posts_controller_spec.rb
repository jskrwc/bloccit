require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do

  # create a parent topic named my_topic
  let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }

  let(:my_sp_post) { my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_int) }


  describe "GET show" do
     it "returns http success" do
       #pass {id:my_sp_post.id} to show as a parameter.  parameters passed to params hash
       get :show, params: { topic_id: my_topic.id, id: my_sp_post.id }
       expect(response).to have_http_status(:success)
     end
     it "renders the #show view" do
       get :show, params: { topic_id: my_topic.id, id: my_sp_post.id }
       expect(response).to render_template :show
     end
     it "assigns my_post to @post" do
       get :show, params: { topic_id: my_topic.id, id: my_sp_post.id }
       expect(assigns(:sponsored_post)).to eq(my_sp_post)
     end
   end

  describe "GET new" do
  # when new invoked, new and unsaved SponsoredPost object created
    it "returns http success" do
      get :new, params: { topic_id: my_topic.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, params: { topic_id: my_topic.id }
      expect(response).to render_template :new
    end

    it "instantiates @sponsored_post" do
      get :new, params: { topic_id: my_topic.id }
      expect(assigns(:sponsored_post)).not_to be_nil
    end
  end


  describe "GET edit" do
   it "returns http success" do
     get :edit, params: { topic_id: my_topic.id, id: my_sp_post.id }
     expect(response).to have_http_status(:success)
   end

   it "renders the #edit view" do
     get :edit, params: { topic_id: my_topic.id, id: my_sp_post.id }
     expect(response).to render_template :edit
   end

# test that edit assigns correct post to be upddated to @post
   it "assigns sponsored_post to be updated to @sponsored_post" do
     get :edit, params: { topic_id: my_topic.id, id: my_sp_post.id }
     sponsored_post_instance = assigns(:sponsored_post)

     expect(sponsored_post_instance.id).to eq my_sp_post.id
     expect(sponsored_post_instance.title).to eq my_sp_post.title
     expect(sponsored_post_instance.body).to eq my_sp_post.body
   end
 end


# add other CRUD .....


  describe "POST create" do
  # when create invoked, new object is persisted to the database
    it "increases the number of SponsoredPost by 1" do
      expect{ post :create, params: { topic_id: my_topic.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_int } } }.to change(SponsoredPost,:count).by(1)
    end

    it "assigns the new sponsored_post to @post" do
      post :create, params: { topic_id: my_topic.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_int } }
      expect(assigns(:sponsored_post)).to eq SponsoredPost.last
    end

    it "redirects to the new sponsored_post" do
      post :create, params: { topic_id: my_topic.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_int } }
      expect(response).to redirect_to [my_topic, SponsoredPost.last]
    end
  end


 describe "PUT update" do
   it "updates sponsored_post with expected attributes" do
     new_title = RandomData.random_sentence
     new_body = RandomData.random_paragraph
     new_price = RandomData.random_int

     put :update, params: { topic_id: my_topic.id, id: my_sp_post.id, sponsored_post: {title: new_title, body: new_body } }

# test that @psponsored_post was updated with title and body passed to update, and @sponsored_post's id was not changed
     updated_sponsored_post = assigns(:sponsored_post)
     expect(updated_sponsored_post.id).to eq my_sp_post.id
     expect(updated_sponsored_post.title).to eq new_title
     expect(updated_sponsored_post.body).to eq new_body
   end

   it "redirects to the updated sponsored_post" do
     new_title = RandomData.random_sentence
     new_body = RandomData.random_paragraph
     new_price = RandomData.random_int

# expect to be redirected to post show view after update
     put :update, params: { topic_id: my_topic.id, id: my_sp_post.id, sponsored_post: {title: new_title, body: new_body } }
     expect(response).to redirect_to [my_topic, my_sp_post]
   end
 end

 describe "DELETE destroy" do
   it "deletes the sponsored_post" do
     delete :destroy, params: { topic_id: my_topic.id, id: my_sp_post.id }

# search db for a sponsored_post with id = my_sp_post_id...returns array
# assign size of array to count, then expect count to =0  (i.e. no matching sponsored_post after destroy called)
     count = SponsoredPost.where({id: my_sp_post.id}).size
     expect(count).to eq 0
   end

   it "redirects to topic show" do
     delete :destroy, params: { topic_id: my_topic.id, id: my_sp_post.id }
     expect(response).to redirect_to my_topic
   end
 end
end
