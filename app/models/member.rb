class Member < ActiveRecord::Base
  attr_accessible :country_id, :email, :password, :provider, :status, :username
end
