class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.integer :client_id
      t.integer :robot_id
      t.datetime :checkout
      t.datetime :checkin

      t.timestamps
    end
  end
end
