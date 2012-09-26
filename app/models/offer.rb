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
  validate :maxcredit
  validate :checkzero
  
  validates_presence_of :offer_start_date, :offer_end_date
  validate :start_date_must_be_before_end_date
  
  validates_presence_of :category_id
   
  validates_presence_of :country_id, :unless => :offer_worldwide

  
  def maxcredit
    
     if offer_max_clicks_per_user.blank? || offer_cr_per_click.blank? || offer_budget.blank?
      return
     end
    
    if offer_max_clicks_per_user * offer_cr_per_click > offer_budget * 100
       errors.add(:offer_max_clicks_per_user," multiply Offer credit per click shouldn't exceed (offer budeget * 100)")
    end    
    
  end
  
  def checkzero
      if offer_max_clicks_per_user==0 || offer_cr_per_click==0 || offer_budget==0
         errors.add(:offer_max_clicks_per_user," or Offer credit per click or offer budget shouldn't be zero")
      end
  end 
  
  def start_date_must_be_before_end_date
    
    if offer_start_date.blank? || offer_end_date.blank?
      return
    end
    start_date_format = format_date(offer_start_date)
    start_date = DateTime.parse(start_date_format)
       
    end_date_format = format_date(offer_end_date)
    end_date = DateTime.parse(end_date_format)
             
    if start_date > end_date
       errors.add(:offer_start_date, "must be before end date")
    end
                                   
  end 
  
  

  def listMyOffers(logged_user_id, page_no)
    offerList = Offer.find_all_by_member_id(logged_user_id)
    if offerList
      @offers = Kaminari.paginate_array(offerList).page(page_no).per(5)
      return @offers
    else
      return false
    end
  end
  
  def sortMyOffers(*args)
   # abort('adfadsf')
    params = args.extract_options!
    if params[:sort_by] == 'current_live'
      offerList = Offer.find(:all, 
        :conditions => ["member_id = #{params[:member_id]} and payment_status = TRUE and offer_stop != TRUE"],
        :order      => 'offer_live_date desc'
      )
    elsif params[:sort_by] == 'awaiting'
      offerList = Offer.find(:all, 
          :conditions => ["member_id = #{params[:member_id]} and offer_status != TRUE"],
          :order => 'created_at desc'
        )
    elsif params[:sort_by] == 'expired'
      offerList = Offer.find(:all, 
          :conditions => ["member_id = #{params[:member_id]} and offer_stop = TRUE"],
          :order => ' created_at desc'
        )  
    end
    
    if offerList
      @offers = Kaminari.paginate_array(offerList).page(params[:page_no]).per(5)
      return @offers
    else
      return ''
    end  
  end
  
  
  def getOffersToPromoteAndSort(*args)
    params = args.extract_options!
    
    if params[:category_id]
      cat_query = "AND category_id =#{params[:category_id]}"
    else
      cat_query = ""
    end
    
    if params[:qs]=="myoffer"     
      @query = "member_id = #{params[:member_id]}   #{cat_query}"
    else
      @query = "member_id != #{params[:member_id]} and payment_status = TRUE  AND (country_id = #{params[:country_id]} or offer_worldwide = TRUE )   #{cat_query}"
    end
    
    
    if params[:sort_by] == 'all'
      offerList = Offer.find(:all, 
      :conditions => [@query])
    elsif params[:sort_by] == 'latest'
      offerList = Offer.find(:all, 
          :conditions => [@query],
          :order => 'created_at desc'
        )
    elsif params[:sort_by] == 'expsoon'
      offerList = Offer.find(:all, 
          :conditions => [@query],
          :order => ' offer_end_date asc'
        )  
     elsif params[:sort_by] == 'highcpc'
      offerList = Offer.find(:all, 
          :conditions => [@query],
          :order => ' offer_cr_per_click desc'
        )
     elsif params[:sort_by] == 'maxnumcredits'
      offerList = Offer.find(:all, 
        :conditions => [@query],
        :order => ' offer_budget desc'
      )
     elsif params[:sort_by] == 'category'
      offerList = Offer.find(:all, 
        :conditions => [@query],
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
    notify_url = notify_url
    if top_up 
      amount = amount
            
    else
      amount = offerList.offer_budget*120/100
    end
    
    
    values = {
      :business       => APP_CONFIG[:paypal_email],
      :cmd            => '_xclick',
      :rm            => 1,
      :upload         => 1,
      :return         => return_url,
      :invoice        => offerList.id,
      :amount         => amount,
      :item_name      => offerList.offer_name,
      :quantity       => 1,
      :currency_code  => 'USD',
      :cert_id => APP_CONFIG[:paypal_cert_id],                
      :notify_url => notify_url
    }
     
     logger.debug "return url: #{return_url}"
      
      
      
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

def time_diff(from_time, to_time)
  
   logger.debug "From-time: #{from_time.to_i}:To-time:to_time.to_i#{to_time.to_i}"
  %w(year month day hour minute second).map do |interval|
   
    distance_in_seconds = (to_time.to_i - from_time.to_i).round(1)
   
    delta = (distance_in_seconds / 1.send(interval)).floor
    delta -= 1 if from_time + delta.send(interval) > to_time
    from_time += delta.send(interval)
    delta    
    
   
  end    
   
end

def time_diff_format(from_time, to_time)
  arr = time_diff(from_time, to_time)
  return "#{arr[0]}Year(s) #{arr[1]} Month(s) #{arr[2]} Day(s) #{arr[3]} Hour(s) #{arr[4]}Minute(s) #{arr[5]}Seconds"  
end

def format_date(var_date)
    @var_date = var_date
    @var_split = @var_date.split("/")
    @return_date=@var_split[2] + "-" + @var_split[0] + "-" + @var_split[1];
    return @return_date
end

def getcredit(member_id)  
  
    offer_redeem_credit = OfferRedeem.where(:members_id => member_id).sum(:amount)
    offer_credit = Offer.where(:member_id => member_id).where(:payment_status => TRUE).sum(:offer_credit)  
    credit_withdraw = CreditsWithdraw.where(:members_id => member_id).sum(:credits)
    return offer_redeem_credit + offer_credit - credit_withdraw
  
end

def updateOfferCredit(new_value,offer_id)
  
    @old_val = Offer.find_by_id(offer_id).read_attribute(:offer_credit)
    new_value = @old_val - new_value
    Offer.find_by_id(offer_id).update_attribute(:offer_credit=>new_value)
    
end

