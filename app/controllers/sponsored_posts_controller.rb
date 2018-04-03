class SponsoredPostsController < ApplicationController

  def show
    #find sponsored_post that corresponds to id in the params passed to show, assign it to @sponsored_post
     @sponsored_post = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_post = SponsoredPost.new
  end

  def edit
    # @topic = Topic.find(params[:id])
    @sponsored_post = SponsoredPost.find(params[:id])
  end

  def create
    @topic = Topic.find(params[:topic_id])
    # call Post.new to create new instance of Post
    @sponsored_post = SponsoredPost.new
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]
    @sponsored_post.price = params[:sponsored_post][:price]

    @sponsored_post.topic = @topic

    # if successfully save post to database, display success message
    if @sponsored_post.save
      # assign value to flash[:notice]
      flash[:notice] = "SponsoredPost was saved."
      redirect_to [@topic, @sponsored_post]
    else
      # if unsuccessfully save, display error message and render new view again
      flash.now[:alert] = "There was an error saving the sponsored_post. Please try again."
      render :new
    end
  end

  def update
    @sponsored_post = SponsoredPost.find(params[:id])
    @sponsored_post.title = params[:sponsored_post][:title]
    @sponsored_post.body = params[:sponsored_post][:body]

    if @sponsored_post.save
      flash[:notice] = "SponsoredPost was updated."
      redirect_to [@sponsored_post.topic, @sponsored_post]
    else
      flash.now[:alert] = "There was an error saving the sponsored_post. Please try again."
      render :edit
    end
  end

  def destroy
    @sponsored_post = SponsoredPost.find(params[:id])

    if @sponsored_post.destroy
      flash[:notice] = "\"#{@sponsored_post.title}\" was deleted successfully."
      redirect_to @sponsored_post.topic
    else
      flash.now[:alert] = "There was an error deleting the sponsored_post."
      render :show
    end
  end

end
