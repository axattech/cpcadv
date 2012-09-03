class OffersController < ApplicationController
  # GET /offers
  # GET /offers.json
  
  layout  false
  
  include ApplicationHelper

   
   before_filter :user_is_logged_in, :except => [:index, :approverejectoffer]
   before_filter :redirect_to_other, :only => :index
  
  def index       
    @offers = Offer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @offers }
    end
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
    @offer = Offer.find(params[:id])

    respond_to do |format|
      format.json { render json: @offer }
    end
  end

  # GET /offers/new
  # GET /offers/new.json
  def new
    @offer = Offer.new

   
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @offer }
    end
  end

  # GET /offers/1/edit
  def edit
    #abort("afad:#{session[:user_id]}")
    offerCheck = Offer.find(:all, 
                           :conditions => ["id = ? and member_id = ?", params[:id], session[:user_id]])    
    if offerCheck.count > 0 
       @offer = Offer.find(params[:id])
       return  
    else
      redirect_to root_url     
    end  
    
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(params[:offer])
    respond_to do |format|
    
    if @offer.save        
        insert_id = @offer.id
        random_string = SecureRandom.hex(5)
        Offer.find(insert_id).update_attribute(:random_code, random_string)
              
        format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
       #  redirect_to :action=>'promoteOffers?qs=myoffer' 
         redirect_to :controller => 'offers', :action => 'promoteAndSortOffers',  :qs => 'myoffer'
       # match 'promoteOffers', to: 'offers#promoteAndSortOffers', as: 'promoteOffers'
         return
        format.json { render json: @offer, status: :created, location: @offer }
      else
        format.html { render action: "new" }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /offers/1
  # PUT /offers/1.json
  def update
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        
         redirect_to :action=>'myOffers' 
         return
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy

    respond_to do |format|
      format.html { redirect_to offers_url }
      format.json { head :no_content }
    end
  end
  
  def approverejectoffer
    @offer1 = Offer.find(params[:id])      
     if @offer1.offer_status
       @offer1.update_attribute(:offer_status , "false")
       flash[:notice] = "You have successfully rejected offer"
     else
       @offer1.update_attribute(:offer_status , "true")
       flash[:notice] = "You have successfully approved offer"
     end        
    redirect_to :controller=>'offers', :action => 'index'    
    #flash[:notice] = ""     
  end
  
  def stopoffer    
     @offer1 = Offer.find(params[:id])       
     if @offer1.offer_stop == false
       @offer1.update_attribute(:offer_stop , "true")
       flash[:offer_stop_notice] = "You have successfully stoped the offer"   
       redirect_url = "http://#{request.host}:#{request.port.to_s}/promoteOffers?qs=myoffer"
       
       redirect_to redirect_url          
       return                      
     end    
  end
  
  
  #method created by emamul khan
  def myOffers
    @logged_user_id = session[:user_id]
    objOff = Offer.new
    @offers = objOff.listMyOffers(session[:user_id], params[:page])
    #logger.debug "OFFER-LIST: #{@offers}"
  end
  
  
  def sortMyOffers
  #  logger.debug "check session #{session[:user_id]}"
   # abort("aborting khan")
    @logged_user_id = session[:user_id]
   # abort('adfa')
    #if !@logged_user_id
     # redirect_to root_url
      #return
    #end
           
   
    if session[:user_id]
      objMember = Member.new
      member_details = objMember.getMemberDataById(session[:user_id])
      arrParams = {
        :page_no      => params[:page],
        :member_id    => session[:user_id],
        :country_id   => member_details.country_id,
        :category_id  => params[:category_id],
        :sort_by      => params[:sort_by],
      }
      
      objOff = Offer.new
      @offers = objOff.sortMyOffers(arrParams)
    end
    render 'offers/promoteAndSortOffers'
  end
  
  
  
  def promoteAndSortOffers
  
   #logger.debug "urlparam: #{params[:qs]}"
    @logged_user_id = session[:user_id]
   
    if !@logged_user_id
      redirect_to root_url
      return
    end
           
    if params[:sort_by]
      @sort_by = params[:sort_by]
    else
      @sort_by = 'all'
    end
    if session[:user_id]
      objMember = Member.new
      member_details = objMember.getMemberDataById(session[:user_id])
      arrParams = {
        :page_no      => params[:page],
        :member_id    => session[:user_id],
        :country_id   => member_details.country_id,
        :category_id  => params[:category_id],
        :sort_by      => @sort_by,
        :qs        => params[:qs]
      }
      
      objOff = Offer.new
      @offers = objOff.getOffersToPromoteAndSort(arrParams)
    end
  end 
  
  
  def offerPayment
    Offer.new.paypal_url(root_url, params[:offer_id])
  end
  
  
  def shareOffer
    
  end
  
 
     
  def topup   
     #encrypted = Offer.new.paypal_encrypted(params[:return_url],payment_notifications_url(:secret => APP_CONFIG[:paypal_secret]),params[:offer_id],true,params[:amount])
     notify_url = payment_notifications_url(:user_action => "topup") 
     redirect_to URI.encode("https://www.sandbox.paypal.com/cgi-bin/webscr" + "?cmd=_xclick&business=#{APP_CONFIG[:paypal_email]}&currency_code=USD&item_name=#{params[:offer_name]}&amount=#{params[:amount]}&invoice=#{params[:offer_id]}&return=#{params[:return_url]}&quantity=1&notify_url=#{notify_url}")     
     return
  end
  
  

  
  
  
  end
