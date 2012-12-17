class CreateFollowingShips < ActiveRecord::Migration
  def change
    create_table :following_ships do |t|
      t.integer :followed_id
      t.integer :following_id

      t.timestamps
    end
  end
end
