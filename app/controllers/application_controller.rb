class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?, :get_posts, :get_comments,
                :require_admin
  
  # if authenticated user, return user object, else return nil, use memoization
  def current_user
    # Each time you use current_user, it might hit the database, so here we save the value to an instance variable, so you only hit the db once per page request.
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    unless logged_in?
      flash[:error] = "Must be logged in to do that."
      redirect_to root_path
    end
  end
  
  def require_same_user
    access_denied unless @user == current_user
  end
  
  def require_admin
    # Notice logged_in is first so it won't throw an error
    access_denied unless logged_in? and current_user.admin?
  end
  
  def get_posts(user)
    @user_posts ||= user.posts.sort_by {|x| x.vote_count }.reverse
  end
  
  def get_comments(user)
    @user_comments ||= user.comments.sort_by {|x| x.vote_count }.reverse
  end
  
  def access_denied
    flash[:error] = "You don't have permissions to do that"
    redirect_to :back
  end
end
