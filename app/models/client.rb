class Client < ActiveRecord::Base
  
  has_many :rentals
  has_many :robots, through: :rentals

  has_secure_password

  validates :username, presence: true
  validates :password, presence: true

  after_initialize :init

  def init
    self.admin  ||= false
    self.save
  end

end
