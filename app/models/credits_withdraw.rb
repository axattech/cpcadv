class CreditsWithdraw < ActiveRecord::Base
  belongs_to :members
  attr_accessible :credits, :paypal_email, :status, :email_verification, :email_verification_code
  
  
  def getCwDataById(member_id)       
    cw_data = CreditsWithdraw.find(member_id)
    if cw_data
      return cw_data
    else
      return false
    end
  end
  
end
