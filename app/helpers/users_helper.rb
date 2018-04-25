module UsersHelper

  def user_has_posts?
    @user.posts.count > 0
  end

  def user_has_comments?
    @user.comments.count > 0
  end

  def user_has_favorites?
    @user.favorites.count > 0
  end

# Assignment 31 helper method
  def user_has_posts_or_comments?
    @user.posts.count + @user.comments.count > 0
  end

end
