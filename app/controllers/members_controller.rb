class MembersController < ApplicationController
  # GET /members
  # GET /members.json
  
  layout false
   
  def index
    
     #logger.debug "admin-user-id: #{session[:admin_user_id]}"
             
     if session[:admin_user_id]
       members = Member.all
       @member_page = Member.all
       @results = Kaminari.paginate_array(members).page(params[:page]).per(5)
       respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @members }
      end
    else
       redirect_to root_url    
       return
    end      
  end

  # GET /members/1
  # GET /members/1.json
  

  # GET /members/new
  # GET /members/new.json
  def new
    @member = Member.new    
  end

  # GET /members/1/edit
  # POST /members
  # POST /members.json
  def create
    @member = Member.new(params[:member])
    if @member.save  
    
      insert_id = @member.id
      random_string = SecureRandom.hex(10)
      Member.find(insert_id).update_attribute(:random_code, random_string)   
    
       flash[:success] = "Member was successfully created."   
       session[:user_id] = insert_id
       redirect_to root_url
       #render   'home/index'  
       
       flash[:success] = "";  
       #render :partial => 'home/index', :locals => { :success => flash[:success] }
    else           
     render   'home/index'             
    end
  end

  # PUT /members/1
  # PUT /members/1.json
  

  # DELETE /members/1
  # DELETE /members/1.json
  
  def banuser    
    if session[:admin_user_id]
    @member1 = Member.find(params[:id])
     if @member1.status
       @member1.update_attribute(:status , "false")
       flash[:notice] = "You have successfully banned user"
     else
       @member1.update_attribute(:status , "true")
       flash[:notice] = "You have successfully permited user"
     end
    redirect_to '/admin/members'  
    else
       redirect_to root_url    
       return
    end 
  end
  
  
  def updateMemberDetail
    objMember = Member.new
    member_data = objMember.getMemberDataById(session[:user_id])        
    #logger.debug "MEMBER-UPDATE-TEST: #{params[:gender]}"
    member_data.username = member_data.username
    member_data.email = member_data.email
    member_data.password = 'CPC@ADV@APP'
    member_data.password_confirmation = 'CPC@ADV@APP'
    member_data.gender = params[:gender]
    member_data.age = params[:age]
    member_data.country_id = params[:country_id]
    member_data.member_detail = true
    #if member_data.update_attributes :gender => params[:gender], :age => params[:age], :country_id => params[:country_id], :member_detail => true         
     if member_data.save! 
       flash[:member_detail_update_notice] = "Updated successfully."
    else
       flash[:member_detail_update_notice] = "Oops! Something went wrong."
    end
     #render   'members/MemberSetValues' 
     redirect_to root_url
  end
  
  
  def mySettings
  logger.debug "current datetime: #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}"
  
    objMember = Member.new
    @member_details = objMember.getMemberDataById(session[:user_id])
  end
  
  def updateMemberSettings
    objMember = Member.new
    member_data = objMember.getMemberDataById(session[:user_id])        
           
    if params[:password].blank?
      flash[:member_setting_update_notice] = "Password can't be blank."
      redirect_to '/mySettings' 
      return   
    end
    
    if params[:password] ==  params[:password_confirmation]       
      member_data.password = params[:password]
      member_data.password_confirmation =  params[:password_confirmation]
      member_data.country_id = params[:country_id]
    
      if member_data.save!
       flash[:member_setting_update_notice] = "Updated successfully."
      else
       flash[:member_setting_update_notice] = "Oops! Something went wrong."
      end
       redirect_to root_url         
    else            
       flash[:member_setting_update_notice] = "Password and confirmation password doesn't match"                
       redirect_to '/mySettings'     
    end
       
  end
  
  def withDrawCash
         
    
    if  @withDrawCash = CreditsWithdraw.find_by_members_id(session[:user_id])  
    
      if @withDrawCash!= params[:email]
        random_string = SecureRandom.hex(16)
      
         if @withDrawCash.update_attributes(:paypal_email => params[:email], :email_verification => FALSE, :email_verification_code => random_string )                    
           
          url = "http://#{request.host}:#{request.port.to_s}/"
          
          UserMailer.paypal_email_verification(session[:user_id],url).deliver
          
          flash[:cw_update_notice] = "Email id has updated successfully."
         else
          flash[:cw_update_notice] = "Oops! Something went wrong."
         end
         redirect_to '/mySettings'        
      end
                         
    else        
      objCw = CreditsWithdraw.new 
      objCw.members_id = session[:user_id]
      objCw.paypal_email =  params[:email]     
      objCw.credits = getcredit(session[:user_id])
      random_string = SecureRandom.hex(16)
      objCw.email_verification_code = random_string
      
      UserMailer.paypal_email_verification(session[:user_id],url).deliver
      
      if objCw.save!   
         flash[:cw_update_notice] = "Email id has added to our database. Within few days you will get credit."
      else
         flash[:cw_update_notice] = "Oops! Something went wrong."
      end
        redirect_to '/mySettings'  
                          
    end
                   
  end
  
  def mailverify
    
    user_id = params[:user_id]
    code = params[:code]
    
     if user_id.blank? || code.blank?
      redirect_to root_url  
      return
    end
    
     @withDrawCash = CreditsWithdraw.find_by_members_id(user_id)  
          
     if @withDrawCash.email_verification_code == code
        @withDrawCash.update_attribute(:email_verification,TRUE)
       render 'members/mailverify'              
     else
       redirect_to root_url  
     end
     
     
  end
  
end
