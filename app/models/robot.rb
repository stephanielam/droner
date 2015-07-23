class Robot < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :rentals
  has_many :clients, through: :rentals

  validates :name, presence: true
  validates :model, presence: true

  if search
    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end

