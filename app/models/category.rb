class Category < ActiveRecord::Base
  attr_accessible :category_name, :status
  validates_uniqueness_of :category_name
  validates_presence_of :category_name
  
  
  def self.getcategoryname(category_id)
    
     category_name = Category.find_by_id(category_id).category_name
     
  end
  
end
