class Member < ActiveRecord::Base
  #attr_accessible :country_id, :email, :password, :provider, :status, :username
  
  attr_accessible :username, :password, :password_confirmation, :country_id, :provider, :status, :email, :age, :gender, :member_detail
  
  attr_accessor :password
  before_save :encrypt_password

  
  
  validates_uniqueness_of :username, :email
  validates_confirmation_of :password
  
  validates_presence_of :username, :email,  :password, :password_confirmation, :gender, :age, :country_id
  validates_numericality_of :age, :only_integer => true, :message => "should be  whole number."
  
  
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
    #logger.debug "MEMBER-TEST-EMAIL: #{auth}"
    
    if checkMember
      if auth['provider'] = checkMember.provider
        return checkMember.id
      else
        return false
      end
    else
      objMember = Member.new
      objMember.username = auth["extra"]["raw_info"]["username"]
      objMember.email = auth["info"]["email"]
      objMember.password = 'CPC@ADV@APP'
      objMember.password_confirmation = 'CPC@ADV@APP'
      objMember.country_id = 'NULL'
      objMember.provider = auth["provider"]
      objMember.member_detail = "FALSE"
      objMember.gender = 'NULL'
      objMember.age = 0
      objMember.save!
      member_details = self.find_by_email(auth["info"]["email"])
      return member_details.id
    end
  end
  
  def self.authenticate_user(email, password)
      user = find_by_email(email)         
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      else
        nil
      end
  end
  
  def getMemberDataById(member_id)
    member_data = Member.find(member_id)
    if member_data
      return member_data
    else
      return false
    end
  end
  
end
