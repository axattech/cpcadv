class PaymentNotification < ActiveRecord::Base
  attr_accessible :params, :offer_id, :status, :transaction_id, :purchased_at
  
   
  belongs_to :offers
  serialize :params
  after_create :mark_cart_as_purchased

  private

  def mark_cart_as_purchased                               
                              
   
    
    params.each do |key,value|
      puts "Param #{key}: #{value}"
      key = value
      puts "key-value::#{key}"
    end
        
          
      
  

    
    
    
                                                                                                                                    
    if status == "Completed" && params[:useraction] == "topup"                    
      TopupPayment.create!(:offers_id => offer_id, :amount => params[:mc_gross])
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
