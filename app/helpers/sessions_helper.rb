module SessionsHelper
  
  #Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end 
  
  #returns the current logged-in user (if any)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remmeber_token])
        log_in user
        @current_user = user
      end
    end 
  end
  
  #Returns true if the user is logged in, returns false otherwise
  def logged_in?
    !current_user.nil?
  end 
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end 

  #Returns true if the given user is the current user.
  def current_user?(user)
    user && user == current_user
  end

  #Redirects to stored location (or the default).
  def redirect_back_or(default)
    redirect_to(session[:fowarding_url] || default)
    session.delete(:fowarding_url)
  end

  #Stores the URL trying to be accessed.
  def store_location
    session[:fowarding_url] = request.original_url if request.get?
  end
end
