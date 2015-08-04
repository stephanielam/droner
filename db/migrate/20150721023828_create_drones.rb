class CreateDrones < ActiveRecord::Migration
  def change
    create_table :drones do |t|
      t.string :name
      t.string :model
      t.integer :price
      t.integer :rentals

      t.timestamps
    end
  end
end
