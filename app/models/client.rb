class Client < ActiveRecord::Base
  has_many :rentals
  has_many :robots, through: :rentals

  validates :username, presence: true
  validates :password, presence: true

  def return_robo
    
  end
end
