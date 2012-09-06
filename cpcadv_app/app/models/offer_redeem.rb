class OfferRedeem < ActiveRecord::Base
  belongs_to :offers
  belongs_to :members
  belongs_to :visitor_trackers
  attr_accessible :amount
end
