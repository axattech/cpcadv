class UserMailer < ActionMailer::Base
  default from: "saroj.m@axat-tech.com"
  
  
  def paypal_email_verification(user_id,url)    
    @user_id = user_id
    @url = url
    @withDrawCash = CreditsWithdraw.find_by_members_id(user_id)       
    mail(:to => @withDrawCash.paypal_email, :subject => "Please verify your paypal email for CPC credits")
  end
  
  
end
