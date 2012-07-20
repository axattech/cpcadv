class HomeController < ApplicationController
  layout false
  
  def index
      @member = Member.new(params[:member])         
  end
  
  
  def login
    
    @member = Member.new(params[:member])   
  
    if session[:user_id]
      #redirect_to :controller=>'AdminUser', :action=>'index'
     end 
    
    if request.post?      
      
         #logger.debug "MEMBER-LOGIN-PASSWORD: #{params[:password]}"
        user = Member.authenticate_user(params[:email], params[:password])
        if user
          session[:user_id] = user.id       
          
          user_settings  = user.member_setting
             
          if user_settings
             
              render   'members/MemberDashboard'
          else
              render   'members/MemberSetValues'
            
          end
          
          
         
          #redirect_to root_url  
          #redirect_to :controller=>'AdminUser', :action=>'index'         
        else
        #flash.now.alert = "Invalid email or password"        
           flash[:signin_notice] = "Invalid email or password" 
           render   'home/index'
        end      
    end

      
       
           
       return
  end
  
  
  
end
