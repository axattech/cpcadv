class Country < ActiveRecord::Base
  
  attr_accessible :id, :ccode, :country
  
  
  def self.getcountryname(country_id)
    
     country_name = Country.find_by_id(country_id)
     
  end
  
end
