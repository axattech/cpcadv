class VisitorTracker < ActiveRecord::Base
  belongs_to :members
  attr_accessible :IP, :refer_url
end
