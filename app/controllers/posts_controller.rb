class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    #find post that corresponds to id in the params passed to show, assign it to @post
     @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    # call Post.new to create new instance of Post
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    # if successfully save post to database, display success message
    if @post.save
      # assign value to flash[:notice]
      flash[:notice] = "Post was saved."
      redirect_to @post     #directs user to post show view
    else
      # if unsuccessfully save, display error message and render new view again
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end


  def edit
  end
end
