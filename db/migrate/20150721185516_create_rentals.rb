class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.integer :renter_id
      t.integer :robot_id
      t.datetime :checkin
      t.datetime :checkout

      t.timestamps
    end
  end
end
