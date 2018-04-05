class SessionsController < ApplicationController

  def new
  end

  def create
# search db for user w specified email (normalized via downcase)
    user = User.find_by(email: params[:session][:email].downcase)

# verify user not nil & password in params hash matches
    if user && user.authenticate(params[:session][:password])
      create_session(user)
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
# delete session - logs user out
    destroy_session(current_user)
    flash[:notice] = "You've been signed out, come back soon!"
    redirect_to root_path
  end



end
