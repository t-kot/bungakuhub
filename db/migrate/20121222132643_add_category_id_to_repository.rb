class AddCategoryIdToRepository < ActiveRecord::Migration
  def change
    add_column :repositories, :category_id, :integer
  end
end
