class HomeController < ApplicationController
  layout false
  
  def index
      @member = Member.new
  end
end
