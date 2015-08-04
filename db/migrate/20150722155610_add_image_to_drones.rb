class AddImageToDrones < ActiveRecord::Migration
  def change
    add_column :drones, :image, :string
  end
end
