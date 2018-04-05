module SessionsHelper
# method to set user_id on session object to user.id (unique for each user)
  def create_session(user)
    session[:user_id] = user.id
  end

# define destroy_session to set session object back to nil
  def destroy_session(user)
    session[:user_id] = nil
  end

# define so don't need to constantly call by finding (= shortcut)
  def current_user
    User.find_by(id: session[:user_id])
  end
end
