class Offer < ActiveRecord::Base
  belongs_to :category
  belongs_to :country
  attr_accessible :offer_budget, :offer_cr_per_click, :offer_description, :offer_end_date, :offer_link, :offer_max_clicks_per_user, :offer_msg, :offer_name, :offer_start_date, :offer_status, :offer_worldwide, :member_id
  attr_accessible :image, :category_id, :country_id
  has_attached_file :image, :styles => { :small => "150x150>" },
                  :url  => "/assets/offers/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/offers/:id/:style/:basename.:extension"
            
  validates_presence_of :offer_name 
  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  validates_presence_of :offer_link, :offer_description, :offer_msg, :offer_budget, :offer_cr_per_click
  validates_numericality_of :offer_budget,:offer_cr_per_click
   
  validates_presence_of  :offer_max_clicks_per_user
  validates_numericality_of :offer_max_clicks_per_user, :only_integer => true, :message => "should be  whole number."
  
  validates_presence_of :offer_start_date, :offer_end_date
  
  validates_presence_of :category_id
   
  validates_presence_of :country_id, :unless => :offer_worldwide


   

   
  

  
  def listMyOffers(logged_user_id, page_no)
    offerList = Offer.find_all_by_member_id(logged_user_id)
    if offerList
      @offers = Kaminari.paginate_array(offerList).page(page_no).per(5)
      return @offers
    else
      return false
    end
  end
  
  def getOffersToPromoteAndSort(*args)
     
  end
  
end
