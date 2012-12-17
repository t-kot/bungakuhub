class AddBodyToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :body, :text
    add_column :feeds, :repository_id, :integer
    add_column :feeds, :target_user_id, :integer
  end
end
