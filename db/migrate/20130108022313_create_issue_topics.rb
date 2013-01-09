class CreateIssueTopics < ActiveRecord::Migration
  def change
    create_table :issue_topics do |t|
      t.string :title
      t.text :body
      t.integer :author_id
      t.boolean :open

      t.timestamps
    end
  end
end
