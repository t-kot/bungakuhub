class AddRepositoryIdToIssueTopic < ActiveRecord::Migration
  def change
    add_column :issue_topics, :repository_id, :integer
  end
end
