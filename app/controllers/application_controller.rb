class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user 
    
    
    private
    def current_admin_user
      @current_admin_user ||= AdminUser.find(session[:admin_user_id]) if session[:admin_user_id]
    end
    helper_method :current_admin_user 
    
end
