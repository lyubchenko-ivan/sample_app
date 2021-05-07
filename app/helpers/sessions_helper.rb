module SessionsHelper
#  вход данного пользователя
  def log_in(user)
    session[:user_id] = user.id
  end

# возврат текущего вошедшего пользователя (если есть)
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # true,  если пользователь зареган
  def logged_in?
    !current_user.nil?
  end

  # выход пользователя
  def log_out
    # session.delete(:user_id)
    reset_session
    @current_user = nil
  end

#  запоминает пользователя в постоянном сеансе
  def remember (user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

#  закрывает постоянный сеанс
def forget(user)
  user.forget
  cookies.delete(:user_id)
  cookies.delete(:remember_token)
end
end
