class Robot < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :rentals
  has_many :clients, through: :rentals

  validates :name, presence: true
  validates :model, presence: true
  validates :price, presence: true, numericality: {only_interger: true}

  scope :price_greater_than,  ->(price) {where("price > ?", price)}
  scope :price_less_than,  ->(price) {where("price < ?", price)}
  scope :search, -> (text) {where("lower(name || model) LIKE ? ", "%"+text.downcase+"%")}
end
