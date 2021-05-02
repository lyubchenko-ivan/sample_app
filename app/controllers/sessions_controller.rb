class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    #  вход
    else
      flash[:danger] = 'Invalid email/password combination' # исправить!
      render 'new'
    end
  end

  def destroy
  end
end
