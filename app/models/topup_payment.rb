class TopupPayment < ActiveRecord::Base
  belongs_to :offers
  attr_accessible :amount
end
