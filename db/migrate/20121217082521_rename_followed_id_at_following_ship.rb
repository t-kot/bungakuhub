class RenameFollowedIdAtFollowingShip < ActiveRecord::Migration
  def up
    rename_column :following_ships, :followed_id, :follower_id
  end

  def down
    rename_column :following_ships, :follower_id, :followed_id
  end
end
