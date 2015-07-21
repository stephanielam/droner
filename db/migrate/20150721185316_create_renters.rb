class CreateRenters < ActiveRecord::Migration
  def change
    create_table :renters do |t|
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
