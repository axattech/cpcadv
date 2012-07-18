class MembersController < ApplicationController
  # GET /members
  # GET /members.json
  
   layout false
   
  def index
    members = Member.all
    @results = Kaminari.paginate_array(members).page(params[:page]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
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
      #redirect_to @member
      render 'new'
    else
      render 'new'
    end
    
  end

  # PUT /members/1
  # PUT /members/1.json
  

  # DELETE /members/1
  # DELETE /members/1.json
  
  def banuser    
    @member1 = Member.find(params[:id])
    
   
     if @member1.status
       @member1.update_attribute(:status , "false")
       flash[:notice] = "You have successfully banned user"
     else
       @member1.update_attribute(:status , "true")
       flash[:notice] = "You have successfully permited user"
     end
  
    
   
    redirect_to :controller=>'members', :action => 'index'    
    #flash[:notice] = ""
  end
  
  
  
end
