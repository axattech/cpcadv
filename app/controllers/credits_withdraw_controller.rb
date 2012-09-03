class CreditsWithdrawController < ApplicationController
  
  layout false   
  include ApplicationHelper   
  before_filter :redirect_to_other
   
  def list
    lists = CreditsWithdraw.all
    @cw_results = Kaminari.paginate_array(lists).page(params[:page]).per(5)

    respond_to do |format|
      format.html # list.html.erb
      format.json { render json: @lists }
    end
  end
  
  def updateCreditStatus
    @cw = CreditsWithdraw.find(params[:id])   
        
    if @cw.status
      @cw.update_attribute(:status , "false")
      flash[:cs_update_notice] = "Updated successfully"
    else       
      @cw.update_attribute(:status , "true")
      flash[:cs_update_notice] = "Updated successfully"
    end        
    redirect_to :controller=>'credits_withdraw', :action => 'list'        
  end
  
  
  
end
