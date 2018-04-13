class FavoritesController < ApplicationController
  before_action :require_sign_in

  def create
# find post to favorite using post_id in params, then create favorite for current_user passing the post to establsh associations for user, post and favorite
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: post)

    if favorite.save
      flash[:notice] = "Post favorited."
    else
      flash[:alert] = "Favoriting failed."
    end

    redirect_to [post.topic, post]
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])

    if favorite.destroy
      flash[:notice] = "Post unfavorited."
    else
      flash[:alert] = "Unfavoriting failed."
    end
      redirect_to [post.topic, post]
  end
end
