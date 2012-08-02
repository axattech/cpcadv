class VisitorTrackerController < ApplicationController
  
  
  def track    
    
    member_random_code = params[:member_random_code]
    random_code = params[:random_code]
    
  #  @query = "member_id = #{member_id} AND random_code = '#{random_code}'"
    
    offerList = Offer.find_by_random_code(random_code)
    memberList = Member.find_by_random_code(member_random_code)
    
    if memberList       
     else
       redirect_to root_url
       return
    end

    if offerList      
      @refer_url = request.env['HTTP_REFERER']
      @ip_addr = request.env['REMOTE_ADDR']    
      
      objVisitorTracker = VisitorTracker.new
      objVisitorTracker.ip = @ip_addr
      objVisitorTracker.refer_url = @refer_url
     
      member_id = memberList.id
          
      objVisitorTracker.members_id =  member_id
      objVisitorTracker.offers_id =  offerList.id
      
     # objVisitorTracker.save!   
      
      if objVisitorTracker.save!
        
        if @refer_url
            @query = "ip = '#{@ip_addr}' AND refer_url != 'null' AND members_id = #{member_id}"            
            ipList = VisitorTracker.find(:all,:conditions => [@query])            
            @count = ipList.count
            
            offer_max_clicks_per_user = offerList.offer_max_clicks_per_user  
                      
            if @count == 1              
              @query1 = "members_id = #{member_id}"                            
              findOfferRedeem =  OfferRedeem.find(:all,:conditions => [@query1])
              @total_count = findOfferRedeem.count
              
              if @total_count < offerList.offer_max_clicks_per_user
                objOfferRedeem =  OfferRedeem.new
                objOfferRedeem.offers_id =   offerList.id
                objOfferRedeem.members_id =   member_id
                objOfferRedeem.visitor_trackers_id = objVisitorTracker.id
                objOfferRedeem.amount = offerList.offer_cr_per_click            
                objOfferRedeem.save!  
              end
                                      
            end
                  
        else
          
        end
        
      end
      
               
    else
      redirect_to root_url
      return
      
    end
    
    
       
  end
  
  
  
end
