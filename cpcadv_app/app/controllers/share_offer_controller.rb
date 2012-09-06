class ShareOfferController < ApplicationController
  
  
  respond_to :html, :json

  def CreateLink    
    @offer1 = Offer.find(params[:id])
    respond_with(@offer1)
  end
  
  
end
