class AddBranchIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :branch_id, :integer
  end
end
