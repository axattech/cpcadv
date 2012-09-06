class Country < ActiveRecord::Base
  
  attr_accessible :id, :ccode, :country
  
  
  def self.getcountryname(country_id)
    
     country_name = Country.find(country_id)
     
  end
  
  def self.listcountryname()
    
     country_list = Country.all
     
  end
  
  
end
