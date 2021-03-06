class VisitorTrackerController < ApplicationController
  def track

    member_random_code = params[:member_random_code]
    random_code = params[:random_code]

    #  @query = "member_id = #{member_id} AND random_code = '#{random_code}'"

    offerList = Offer.find_by_random_code(random_code)
    memberList = Member.find_by_random_code(member_random_code)

    if memberList
      # redirect_to offerList.offer_link
      else
      redirect_to root_url
      return
    return
    end

    end_date_format = format_date(offerList.offer_end_date)
    end_date = DateTime.parse(end_date_format)

    if Date.today > end_date
      redirect_to root_url
      return
    end

    offer_redeem_credit = OfferRedeem.where(:offers_id => offerList.id).sum(:amount)

    if (offer_redeem_credit / 100) >= offerList.offer_budget
      redirect_to root_url
      return
    end

    if offerList
      @refer_url = request.env["HTTP_REFERER"]

      @req_uri = request.env['REQUEST_URI']

      @ip_addr = request.remote_ip
      puts "refer url#{request.env["HTTP_REFERER"]}"

      objVisitorTracker = VisitorTracker.new
      objVisitorTracker.ip = @ip_addr
      objVisitorTracker.refer_url = @refer_url

      member_id = memberList.id

      objVisitorTracker.members_id =  member_id
      objVisitorTracker.offers_id =  offerList.id

      # objVisitorTracker.save!

      if objVisitorTracker.save!
     
        if @refer_url
          
          if @refer_url.match(APP_CONFIG[:site_domain])
          else
            @query = "ip = '#{@ip_addr}' AND refer_url != 'null' AND members_id = #{member_id}"
          ipList = VisitorTracker.find(:all,:conditions => [@query])
          @count = ipList.count

          offer_max_clicks_per_user = offerList.offer_max_clicks_per_user
          
          puts "ip-count: #{@count}"
        
          if @count == 1
          puts "inside loop:"
            @query1 = "members_id = #{member_id}"
            findOfferRedeem =  OfferRedeem.find(:all,:conditions => [@query1])
            @total_count = findOfferRedeem.count

            if member_id != offerList.  member_id
              if @total_count < offerList.offer_max_clicks_per_user
                objOfferRedeem =  OfferRedeem.new
                objOfferRedeem.offers_id =   offerList.id
                objOfferRedeem.members_id =   member_id
                objOfferRedeem.visitor_trackers_id = objVisitorTracker.id
                objOfferRedeem.amount = offerList.offer_cr_per_click
                objOfferRedeem.save!

                objOffer = Offer.new
                offer_data = Offer.find_by_id(offerList.id)
              #logger.debug "MEMBER-UPDATE-TEST: #{params[:gender]}"
              offer_old_credit_value = offer_data.offer_credit

              offer_data.offer_credit =  offer_old_credit_value - offerList.offer_cr_per_click
              offer_data.save!
              end
            end

          end
           
          end
          
          
          
                                   
          
          redirect_to offerList.offer_link
          return

        else
          redirect_to offerList.offer_link
          return
        end

      end

    else
      redirect_to root_url
      return
    return

    end

  end

end
