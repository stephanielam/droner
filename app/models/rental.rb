class Rental < ActiveRecord::Base

  belongs_to :robot
  belongs_to :client

  validates :robot_id, presence: true
  validates :client_id, presence: true


end
