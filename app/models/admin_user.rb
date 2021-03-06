class AdminUser < ActiveRecord::Base

   attr_accessible :email, :hashed_password, :salt_password
   
  
  
    # If a user matching the credentials is found, returns the User object.
    # If no matching user is found, returns nil.
  
    
    def self.authenticate(email, password)
    
      user = find_by_email(email)
      
    
      if user && user.hashed_password == BCrypt::Engine.hash_secret(password, user.salt_password)
        user
      else
        nil
      end
    
    end    
    
    
    
    
    
    
    
end