class Member < ActiveRecord::Base
  #attr_accessible :country_id, :email, :password, :provider, :status, :username
  
  attr_accessible :username, :password, :password_confirmation, :country_id, :provider, :status
  
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
  
  #method defined by emamul khan
  def self.saveMemberWhileLogin(auth)
    #logger.debug "MEMBER-TEST: #{auth["extra"]["raw_info"]["username"]}"
    #abort('khan')
    checkMember = self.find_by_email(auth["info"]["email"])
    
    
    if checkMember
      return false
    else
      objMember = Member.new
      objMember.username = auth["extra"]["raw_info"]["username"]
      objMember.email = auth["info"]["email"]
      objMember.password = 'CPC@ADV@APP'
      objMember.password_confirmation = 'CPC@ADV@APP'
      objMember.country_id = 'NULL'
      objMember.provider = auth["provider"]
      objMember.save!
      member_details = self.find_by_email(auth["info"]["email"])
      return member_details.id
    end
  end
end
