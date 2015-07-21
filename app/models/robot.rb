class Robot < ActiveRecord::Base
  has_many :rentals
  has_many :clients, through: :rentals

  validates :name, presence: true
  validates :model, presence: true
end
