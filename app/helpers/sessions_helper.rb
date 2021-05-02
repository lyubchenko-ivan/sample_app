module SessionsHelper
#  вход данного пользователя
  def log_in(user)
    session[:user_id] = user.id
  end
end
