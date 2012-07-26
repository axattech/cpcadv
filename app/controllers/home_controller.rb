class HomeController < ApplicationController
  layout false
  
  def index
      @member = Member.new(params[:member])   
      if session[:user_id]
        objMember = Member.new
        member_data = objMember.getMemberDataById(session[:user_id])
        member_detail  = member_data.member_detail
        @member_provider = member_data.provider
        
        if member_detail
          objOff = Offer.new
          @offers = objOff.listMyOffers(session[:user_id], params[:page])
          render   'members/MemberDashboard'
        else
          render   'members/MemberSetValues'
        end      
      end
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
           
          #redirect_to :controller=>'AdminUser', :action=>'index'         
          #render   'members/MemberDashboard'
        else
        #flash.now.alert = "Invalid email or password"        
           flash[:signin_notice] = "Invalid email or password" 
           #render   'home/index'
        end   
        redirect_to root_url    
    end
       return
  end
  
  
  
end
