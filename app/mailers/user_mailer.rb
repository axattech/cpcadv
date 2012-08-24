class UserMailer < ActionMailer::Base
  default from: "saroj.m@axat-tech.com"
  
  
  def paypal_email_verification(user_id)    
    @user_id = user_id
    @withDrawCash = CreditsWithdraw.find_by_members_id(user_id)   
    
    
    logger.debug "user email: #{@withDrawCash.paypal_email}"
       
    mail(:to => @withDrawCash.paypal_email, :subject => "Please verify your paypal email for CPC credits")
  end
  
  
end
