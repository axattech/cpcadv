class Member < ActiveRecord::Base
  #attr_accessible :country_id, :email, :password, :provider, :status, :username
  
  attr_accessible :username, :password, :password_confirmation, :country_id, :provider
  
  attr_accessor :password
  before_save :encrypt_password

  
  validates_confirmation_of :password
  validates_presence_of :username, :password, :password_confirmation, :country_id
  validates_uniqueness_of :username

  
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  
end
