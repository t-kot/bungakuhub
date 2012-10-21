class AddSexIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :sex_id, :integer
  end
end
