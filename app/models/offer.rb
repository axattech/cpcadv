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
    params = args.extract_options!
    
    if params[:sort_by] == 'all'
      offerList = Offer.find(:all, 
      :conditions => ["member_id != ? and (country_id = ? or offer_worldwide = TRUE )", params[:member_id], params[:country_id]])
    elsif params[:sort_by] == 'latest'
      offerList = Offer.find(:all, 
          :conditions => ["member_id != ? and (country_id = ? or offer_worldwide = TRUE )", params[:member_id], params[:country_id]],
          :order => 'created_at desc'
        )
    elsif params[:sort_by] == 'expsoon'
      offerList = Offer.find(:all, 
          :conditions => ["member_id != ? and (country_id = ? or offer_worldwide = TRUE )", params[:member_id], params[:country_id]],
          :order => ' offer_end_date asc'
        )  
     elsif params[:sort_by] == 'highcpc'
      offerList = Offer.find(:all, 
          :conditions => ["member_id != ? and (country_id = ? or offer_worldwide = TRUE )", params[:member_id], params[:country_id]],
          :order => ' offer_cr_per_click desc'
        )
     elsif params[:sort_by] == 'maxnumcredits'
      offerList = Offer.find(:all, 
        :conditions => ["member_id != ? and (country_id = ? or offer_worldwide = TRUE )", params[:member_id], params[:country_id]],
        :order => ' offer_budget desc'
      )
     elsif params[:sort_by] == 'category'
      offerList = Offer.find(:all, 
        :conditions => ["member_id != ? and (country_id = ? or offer_worldwide = TRUE ) and category_id = ? ", params[:member_id], params[:country_id], params[:category_id]],
        :order => ' offer_budget desc'
      )
    end
    
    if offerList
      @offers = Kaminari.paginate_array(offerList).page(params[:page_no]).per(5)
      return @offers
    else
      return false
    end
    #logger.debug "EMAMULBHAI: #{offerList}"
  end
  
  def getOfferDataById(offer_id)
    offer_data = Offer.find(offer_id)
    if offer_data
      return offer_data
    else
      return false
    end
  end

  def getCategoriesIfOfferExists
    objCat = Category.new
    @categoryList = objCat.getAllCategories
    @categoryIds = '' 
    @i = 0
    @categoryList.each do |category| 
      @i += 1
      if @i < @categoryList.count.to_i
        @categoryIds += category.id.to_s + ','
      else
        @categoryIds += category.id.to_s
      end
    end
    offerList = Category.find(:all, 
      :conditions => ["member_id != ? and (country_id = ? or offer_worldwide = TRUE )", params[:member_id], params[:country_id]])
  end
  
   def paypal_encrypted(return_url, notify_url,offer_id,top_up,amount)
    offerList = Offer.find(offer_id)
    
    if top_up 
      amount = amount
            
    else
      amount = offerList.offer_budget*120/100
    end
    
    values = {
      :business       => APP_CONFIG[:paypal_email],
      :cmd            => '_xclick',
      :upload         => 1,
      :return         => return_url,
      :invoice        => offerList.id,
      :amount         => amount,
      :item_name      => offerList.offer_name,
      :quantity       => 1,
      :currency_code  => 'USD',
      :cert_id => 'UW7T4YNMGMBT2'
    }
    
    encrypt_for_paypal(values)
  end
  
  
  PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
  APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
  APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")

  def encrypt_for_paypal(values)
    signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end
  
  
  
  
end
