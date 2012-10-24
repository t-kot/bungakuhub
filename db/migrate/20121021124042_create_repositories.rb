class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :type
      t.integer :user_id
      t.integer :repository_type_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
