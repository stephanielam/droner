class Rental < ActiveRecord::Base

  belongs_to :drone
  belongs_to :client

  validates :drone_id, presence: true
  validates :client_id, presence: true


end
