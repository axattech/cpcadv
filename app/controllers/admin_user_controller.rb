class AdminUserController < ApplicationController
  
  layout false
  
   def index
    if session[:admin_user_id]
      nil
    else
      redirect_to root_url
    end
    
  end
  
  def login
    
    if request.post?
      
        user = AdminUser.authenticate(params[:email], params[:password])
        if user
          session[:admin_user_id] = user.id        
          
          redirect_to :controller=>'AdminUser', :action=>'index'
          

        else
        flash.now.alert = "Invalid email or password"
        end
      
    end
          
  end

  def logout
        
  session[:admin_user_id] = nil
  
  redirect_to admin_url
    
  end

  def change_password
  end

  def forgot_password
  end
end
