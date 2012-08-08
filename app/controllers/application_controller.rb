class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
    def current_user
      @current_user ||= Member.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user 
    
    
  private
    def current_admin_user
      @current_admin_user ||= AdminUser.find(session[:admin_user_id]) if session[:admin_user_id]
    end
    helper_method :current_admin_user 
    
    
    private
    
    def redirect_to_other      
      if session[:admin_user_id]
      else      
          redirect_to root_url                         
      end      
       
    end
    
    helper_method :redirect_to_other 
    
    
    private
    
     def user_is_logged_in           
      if !session[:user_id]      
          redirect_to root_url                         
      end       
    end
    
    helper_method :user_is_logged_in 
    
    
end
