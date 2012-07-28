class PaymentNotification < ActiveRecord::Base
  attr_accessible :params, :offer_id, :status, :transaction_id, :purchased_at
  
   
  belongs_to :offers
  serialize :params
  after_create :mark_cart_as_purchased

  private

  def mark_cart_as_purchased
    if status == "Completed"             
       #logger.debug "test-offer-id2: #{offer_id}"      
      @offer = Offer.find_by_id(offer_id)
      @offer.payment_status = 'true'       
      @offer.save                       
    end
  end
  
  
end
