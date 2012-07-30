class PaymentNotification < ActiveRecord::Base
  attr_accessible :params, :offer_id, :status, :transaction_id, :purchased_at
  
   
  belongs_to :offers
  serialize :params
  after_create :mark_cart_as_purchased

  private

  def mark_cart_as_purchased                               
                              
   
    
    params.each do |key,value|
      puts "Param #{key}: #{value}"
      
      if(key=="mc_gross")
        @amount = value
      end
      
      if(key=="user_action")
        @user_action = value
      end
     
     if(key=="invoice")
        @offer_id = value
      end
     
    end
        
     puts "key-value-offer-id#{@offer_id}"
      
                                                                                                                                    
    if status == "Completed" && @user_action == "topup"   
                     
      TopupPayment.create!(:offers_id =>@offer_id.to_i, :amount => @amount)
      puts "inside top up"
    else
    
      if status == "Completed"             
        logger.debug "test-offer-id-now: #{@offer_id}"      
        @offer = Offer.find_by_id(@offer_id)
        @offer.payment_status = 'true'       
        @offer.save                    
         puts "inside payment"   
      end           
    end            
  end
  
  
end
