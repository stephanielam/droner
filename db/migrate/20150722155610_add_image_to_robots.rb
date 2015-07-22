class AddImageToRobots < ActiveRecord::Migration
  def change
    add_column :robots, :image, :string
  end
end
