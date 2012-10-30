class CreateBranchKommits < ActiveRecord::Migration
  def change
    create_table :branch_kommits do |t|
      t.integer :kommit_id
      t.integer :branch_id

      t.timestamps
    end
  end
end
