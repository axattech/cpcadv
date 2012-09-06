class VisitorTrackers < ActiveRecord::Base
  belongs_to :offers
  belongs_to :members
  attr_accessible :ip, :refer_url
end
