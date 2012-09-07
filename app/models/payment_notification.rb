class PaymentNotification < ActiveRecord::Base
  attr_accessible :params, :offer_id, :status, :transaction_id, :purchased_at
  
   
  belongs_to :offers
  serialize :params
  after_create :mark_cart_as_purchased

  private

  def mark_cart_as_purchased                               
                              
   
    
    params.each do |key,value|
     # puts "Param #{key}: #{value}"      
      if(key=="mc_gross")
        @amount = value
      end
      
      if(key=="user_action")
        @user_action = value
      end              
    end
        
    
      
                                                                                                                                    
    if status == "Completed" && @user_action == "topup"                                
       #puts "key-value-offer-id#{offer_id}"
      objTopupPayment = TopupPayment.new
      objTopupPayment.offers_id = offer_id
      objTopupPayment.amount = @amount
      objTopupPayment.save!
      
      old_offer_credit = Offer.find_by_id(offer_id).read_attribute(:offer_credit)
      amount = @amount*100
      puts "Offer credit amount: #{amount.to_f}"
      new_offer_credit = amount.to_f + old_offer_credit.to_f
      
       puts "new Offer credit: #{new_offer_credit}"
       
      

     


      @offer = Offer.find_by_id(offer_id)
      @offer.offer_credit = new_offer_credit
      @offer.save 







      #puts "inside top up"
    else    
      if status == "Completed"             
        logger.debug "test-offer-id-now: #{offer_id}"      
        @offer = Offer.find_by_id(offer_id)
        
        @offer_credit = Offer.find_by_id(offer_id).read_attribute(:offer_budget) * 12000/100
        
        @offer.offer_credit = @offer_credit
        
        
        @offer.payment_status = 'true'       
        @offer.offer_live_date = Time.now             
        @offer.save        
        
         #logger.debug "current datetime: #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}"
                    
        #puts "inside payment"   
      end           
    end            
  end
  
  
end
