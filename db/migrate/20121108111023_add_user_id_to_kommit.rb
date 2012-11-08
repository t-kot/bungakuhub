class AddUserIdToKommit < ActiveRecord::Migration
  def change
    add_column :kommits, :user_id, :integer
  end
end
