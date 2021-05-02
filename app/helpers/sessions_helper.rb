module SessionsHelper
#  вход данного пользователя
  def log_in(user)
    session[:user_id] = user.id
  end
  #возврат текущего вошедшего пользователя (если есть)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
end
