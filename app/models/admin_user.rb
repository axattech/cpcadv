class AdminUser < ActiveRecord::Base
   #attr_accessible :email, :hashed_password
  
  
    # If a user matching the credentials is found, returns the User object.
    # If no matching user is found, returns nil.
  
    
    def self.authenticate(email, password)
    user = find_by_email_and_hashed_password(email,password)
    if user
      user
    else
      nil
    end
  end    
    
    
    
    
end