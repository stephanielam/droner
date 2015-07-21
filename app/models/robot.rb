class Robot < ActiveRecord::Base
  has_many :rentals
  has_many :renters, through: :rentals

  validates :name, presence: true
  validates :model, presence: true
end
