class AdminUserController < ApplicationController
  
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
           
          flash.now.alert =  user1   
          
          redirect_to :controller=>'admin_user', :action=>'index'

        else
        flash.now.alert = "Invalid email or password"
        end
      
    end
          
  end

  def logout
  end

  def change_password
  end

  def forgot_password
  end
end
