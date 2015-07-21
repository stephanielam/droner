class Rental < ActiveRecord::Base
  belongs_to :robot
  belongs_to :renter
end
