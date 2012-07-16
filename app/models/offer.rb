class Offer < ActiveRecord::Base
  belongs_to :category
  belongs_to :country
  attr_accessible :offer_budget, :offer_cr_per_click, :offer_description, :offer_end_date, :offer_link, :offer_max_clicks_per_user, :offer_msg, :offer_name, :offer_start_date, :offer_status, :offer_worldwide, :image, :category, :country  
  
 has_attached_file :image, :styles => { :small => "150x150>" },
                  :url  => "/assets/offers/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/offers/:id/:style/:basename.:extension"
                  
                  
                  
                  

validates_attachment_presence :image
validates_attachment_size :image, :less_than => 5.megabytes
validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  
end
