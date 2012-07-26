class PaymentNotification < ActiveRecord::Base
  attr_accessible :params, :offer_id, :status, :transaction_id, :purchased_at
  
   
  belongs_to :offers
  serialize :params
  after_create :mark_cart_as_purchased

  private

  def mark_cart_as_purchased
    if status == "Completed"
      
     # PaymentNotification.update_attribute(:purchased_at, Time.now)
    end
  end
  
  
end
