class PostsController < ApplicationController

  before_action :require_sign_in, except: :show

  # CP 21 -- remove bc index view no longer needed (posts displayed with topics now)
  # def index
  #   @posts = Post.all
  # end

  def show
    #find post that corresponds to id in the params passed to show, assign it to @post
     @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    # call Post.new to create new instance of Post
    # @post = Post.new
    # @post.title = params[:post][:title]
    # @post.body = params[:post][:body]
    @topic = Topic.find(params[:topic_id])
    @post =@topic.posts.build(post_params)  #use private method for mass assign
    @post.user = current_user

    # if successfully save post to database, display success message
    if @post.save
      # assign value to flash[:notice]
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      # if unsuccessfully save, display error message and render new view again
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    # @post.title = params[:post][:title]
    # @post.body = params[:post][:body]
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

end
