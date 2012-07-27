class OffersController < ApplicationController
  # GET /offers
  # GET /offers.json
  
  layout  false
  
  
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
    @offer = Offer.find(params[:id])
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(params[:offer])
   

    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
         redirect_to :action=>'myOffers' 
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
  
  #method created by emamul khan
  def myOffers
    @logged_user_id = session[:user_id]
    objOff = Offer.new
    @offers = objOff.listMyOffers(session[:user_id], params[:page])
    #logger.debug "OFFER-LIST: #{@offers}"
  end
  
  def promoteAndSortOffers
    @logged_user_id = session[:user_id]
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
        :sort_by      => @sort_by
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
  
  def promoteOffers1        

      
  end 
   PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
  APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
  APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")
    
  
  def topup
    
    
    
    
   paypal_uri = URI.parse('https://www.sandbox.paypal.com/cgi-bin/webscr')
req = Net::HTTP::Post.new(paypal_uri.path)
req.set_form_data({:cmd => "_notify-sync"})
sock = Net::HTTP.new(paypal_uri.host, 443)
sock.use_ssl = true
store = OpenSSL::X509::Store.new
store.add_cert OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)
store.add_cert OpenSSL::X509::Certificate.new(APP_CERT_PEM)
sock.cert_store = store
sock.start do |http|
  response = http.request(req)
end

    
    

  
  end
    
end
