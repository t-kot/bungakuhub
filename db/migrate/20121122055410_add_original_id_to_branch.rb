class AddOriginalIdToBranch < ActiveRecord::Migration
  def change
    add_column :branches, :original_id, :integer
  end
end
