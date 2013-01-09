class CreateIssueComments < ActiveRecord::Migration
  def change
    create_table :issue_comments do |t|
      t.integer :issue_topic_id
      t.text :body
      t.integer :author_id

      t.timestamps
    end
  end
end
