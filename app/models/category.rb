class Category < ActiveRecord::Base
  attr_accessible :category_name, :status
  validates_uniqueness_of :category_name
  validates_presence_of :category_name
end
