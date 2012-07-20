class MembersController < ApplicationController
  # GET /members
  # GET /members.json
  
   layout false
   
  def index
             
     if session[:admin_user_id]
       
       members = Member.all
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
      flash[:success] = "Member was successfully created."   
      render   'home/index'  
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
  
    
   
    redirect_to :controller=>'members', :action => 'index'   
    else
       redirect_to root_url    
       return

    end 
    #flash[:notice] = ""country_id
  end
  
  def updatevalue
  
    @member1 = Member.find_by_id(session[:user_id])        
    
    if @member1.update_attributes :gender => params[:gender], :age => params[:age], :country_id => params[:country_id], :member_setting => true         

       flash[:user_update_valuse_notice] = "Updated successfully."
    else
         flash[:user_update_valuse_notice] = "Oops! Something went wrong."
         
    end
     render   'members/MemberSetValues' 
  end
  
  
end
