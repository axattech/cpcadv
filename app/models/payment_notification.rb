class PaymentNotification < ActiveRecord::Base
  attr_accessible :params, :offer_id, :status, :transaction_id, :purchased_at
  
   
  belongs_to :offers
  serialize :params
  after_create :mark_cart_as_purchased

  private

  def mark_cart_as_purchased   
                       
              logger.debug "payment-secret: #{params[:secret]}"          
                       
                                                                                                 
    if status == "Completed" && params[:secret] == APP_CONFIG[:paypal_secret]   
      
       logger.debug "test-offer-message: #{offer_id}"   
      
      @offer = Offer.find_by_id(offer_id)
      @offer.offer_msg = 'test offer msg test again'       
      @offer.save  
    else
      if status == "Completed"             
         logger.debug "test-offer-id-now: #{offer_id}"      
        @offer = Offer.find_by_id(offer_id)
        @offer.payment_status = 'true'       
        @offer.save                       
      end           
    end
            
  end
  
  
end
