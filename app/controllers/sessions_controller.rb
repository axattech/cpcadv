class SessionsController < ApplicationController
    def create
        auth = request.env["omniauth.auth"]
       
        @member_id = Member.saveMemberWhileLogin(auth)
        #logger.debug "MEMBER-TEST: #{@member_id}"
        #auth = request.env["omniauth.auth"]
        #user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
        if @member_id
          session[:user_id] = @member_id
        else
          #logger.debug "MEMBER-TEST-IN-ELSE: #{@member_id}"
          flash[:notice] = "Email id already exits."
        end
        redirect_to root_url
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => "Signed out!"
    end
end



