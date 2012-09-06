class SessionsController < ApplicationController
    def create
        auth = request.env["omniauth.auth"]
       
        @member_id = Member.saveMemberWhileLogin(auth)
        if @member_id
          session[:user_id] = @member_id
           #logger.debug "MEMBER-LOGIN-PASSWORD: #{params[:password]}"
        else
          #logger.debug "MEMBER-TEST-IN-ELSE: #{@member_id}"
          flash[:notice] = "Email id already exits."
        end
        redirect_to root_url
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url
    end
end



