class SessionsController < ApplicationController

  def new
    session[:return_to] ||= request.referer
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You're logged in!"
      redirect_to session.delete(:return_to)
    else
      flash.now[:danger] = 'There was an issue with your login info.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You're logged out."
    redirect_back(fallback_location: root_path)
  end

end