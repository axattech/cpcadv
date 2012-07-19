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
      format.html # show.html.erb
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
    #@offerList = Offer.find_by_member_id(@logged_user_id)
    
    offerList = Offer.find_all_by_member_id(session[:user_id])
    #logger.debug "MEMBER-TEST: #{offerList}"
    @offers = Kaminari.paginate_array(offerList).page(params[:page]).per(5)
  end
  
end
